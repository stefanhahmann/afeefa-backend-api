module DataModules::Actor::Concerns::HasActorRelations

  extend ActiveSupport::Concern

  included do
    # ASSOCIATIONS
    has_many :actor_relations_i_have_associated,
      class_name: DataModules::Actor::ActorRelation, foreign_key: 'associating_actor_id'
    has_many :actor_relations_that_associated_me,
      class_name: DataModules::Actor::ActorRelation, foreign_key: 'associated_actor_id'

    has_many :actors_i_have_associated, through: :actor_relations_i_have_associated, source: :associated_actor
    has_many :actors_that_associated_me, through: :actor_relations_that_associated_me, source: :associating_actor

    # projects

    has_many :project_relations,
      ->() { DataModules::Actor::ActorRelation.project }, class_name: DataModules::Actor::ActorRelation,
      foreign_key: 'associating_actor_id'
    has_many :project_initiators_relations,
      ->() { DataModules::Actor::ActorRelation.project }, class_name: DataModules::Actor::ActorRelation,
      foreign_key: 'associated_actor_id'

    has_many :projects, through: :project_relations, source: :associated_actor
    has_many :project_initiators, through: :project_initiators_relations, source: :associating_actor

    def projects_to_hash
      projects.map(&method(:actor_to_hash))
    end

    def project_initiators_to_hash
      project_initiators.map(&method(:actor_to_hash))
    end

    # networks

    has_many :network_member_relations,
      ->() { DataModules::Actor::ActorRelation.network }, class_name: DataModules::Actor::ActorRelation,
      foreign_key: 'associating_actor_id'
    has_many :network_relations,
      ->() { DataModules::Actor::ActorRelation.network }, class_name: DataModules::Actor::ActorRelation,
      foreign_key: 'associated_actor_id'

    has_many :networks, through: :network_relations, source: :associating_actor
    has_many :network_members, through: :network_member_relations, source: :associated_actor

    def networks_to_hash
      networks.map(&method(:actor_to_hash))
    end

    def network_members_to_hash
      network_members.map(&method(:actor_to_hash))
    end

    # partners

    has_many :partner_relations_i_have_associated,
      ->() { DataModules::Actor::ActorRelation.partner }, class_name: DataModules::Actor::ActorRelation,
      foreign_key: 'associating_actor_id'
    has_many :partner_relations_that_associated_me,
      ->() { DataModules::Actor::ActorRelation.partner }, class_name: DataModules::Actor::ActorRelation,
      foreign_key: 'associated_actor_id'

    has_many :partners_i_have_associated, through: :partner_relations_i_have_associated, source: :associated_actor
    has_many :partners_that_associated_me, through: :partner_relations_that_associated_me, source: :associating_actor

    def partners_to_hash
      partners.map(&method(:actor_to_hash))
    end

    # ASSOCIATION METHODS
    def actors
      # TODO: Change to Actor
      Orga.where(id: actors_i_have_associated.pluck(:id) + actors_that_associated_me.pluck(:id))
    end

    def partners
      # TODO: Change to Actor
      Orga.where(id: partners_i_have_associated.pluck(:id) + partners_that_associated_me.pluck(:id))
    end

    def actor_to_hash(actor)
      actor.to_hash(
        attributes: self.class.default_attributes_for_json,
        relationships: self.class.default_relations_for_json
      )
    end

  end

end
