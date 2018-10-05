Geocoder.configure(
  lookup: :google,
  use_https: true,
  language: :de,
  cache: {},
  always_raise: :all
)

Nominatim.configure do |config|
  # TODO enter valid afeefa e-mail address
  # https://wiki.openstreetmap.org/wiki/DE:Nominatim#Parameter
  # "Wenn sie eine große Anzahl an Suchabfragen abschicken wollen, geben sie bitte ihre Mail-Adresse in der Abfrage an.
  # "Diese Info wird vertraulich behandelt und nur verwendet um mit ihnen bei Problemen in Kontakt treten zu können. Siehe auch unsere Usage-Policy."
  config.email = '@afeefa.de'
  config.endpoint = 'https://nominatim.openstreetmap.org/search'
  config.endpoint = 'https://nominatim.openstreetmap.org'
end

