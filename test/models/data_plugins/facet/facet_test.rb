require 'test_helper'

module DataPlugins::Facet
  class FacetTest < ActiveSupport::TestCase

    should 'validate facet' do
      facet = create(:facet_with_items, facet_items_count: 2)
      assert_equal 2, facet.facet_items.count
      assert_equal facet.facet_items.first.title,
        JSON.parse(facet.to_json)['relationships']['facet_items']['data'].first['attributes']['title']
    end

    should 'remove facet items when removing facet' do
      facet = create(:facet_with_items_and_sub_items, owner_types: ['Orga'])
      parent = facet.facet_items.select { |item| item.parent == nil }.first

      assert_difference -> { DataPlugins::Facet::FacetItem.count }, -6 do # 2 parent + 4 subs
        facet.destroy
      end
    end

    should 'remove owners when removing facet' do
      facet = create(:facet_with_items_and_sub_items, owner_types: ['Orga'])

      parent = facet.facet_items.select { |item| item.parent == nil }.first
      sub_item = parent.sub_items.first

      orga = create(:orga)
      parent.link_owner(orga)
      sub_item.link_owner(orga)

      assert_equal [parent, sub_item], orga.facet_items

      assert_difference -> { DataPlugins::Facet::FacetItemOwner.count }, -2 do
        facet.destroy

        orga.reload

        assert_equal [], orga.facet_items
      end
    end

    should 'deliver main facet of' do
      facet = create(:facet_with_items_and_sub_items, owner_types: [{type: 'Orga', isMain: true}, 'Event', {type: 'Offer', isMain: true}])
      assert_equal ['Orga', 'Event', 'Offer'], facet.owner_types.map { |owner_type| owner_type.owner_type }
      assert_equal 'Orga', facet.main_facet_of_to_hash

      facet = create(:facet_with_items_and_sub_items, owner_types: [{type: 'Orga', isMain: false}, 'Event', {type: 'Offer', isMain: true}])
      assert_equal ['Orga', 'Event', 'Offer'], facet.owner_types.map { |owner_type| owner_type.owner_type }
      assert_equal 'Offer', facet.main_facet_of_to_hash

      facet = create(:facet_with_items_and_sub_items, owner_types: ['Orga', 'Event', 'Offer'])
      assert_equal ['Orga', 'Event', 'Offer'], facet.owner_types.map { |owner_type| owner_type.owner_type }
      assert_nil facet.main_facet_of_to_hash
    end

  end
end
