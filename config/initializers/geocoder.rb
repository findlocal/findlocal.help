Geocoder.configure(
  lookup: :nominatim,           # name of geocoding service (symbol)
  units: :km,                   # :km for kilometers or :mi for miles
  # timeout: 3,                 # geocoding service timeout (secs)
  # ip_lookup: :ipinfo_io,      # name of IP address geocoding service (symbol)
  # language: :en,              # ISO-639 language code
  # use_https: false,           # use HTTPS for lookup requests? (if supported)
  # http_proxy: nil,            # HTTP proxy server (user:pass@host:port)
  # https_proxy: nil,           # HTTPS proxy server (user:pass@host:port)
  # api_key: nil,               # API key for other geocoding services
  # cache: nil,                 # cache object (must respond to #[], #[]=, and #del)
  # cache_prefix: 'geocoder:',  # prefix (string) to use for all cache keys
  # always_raise: [],           # exceptions that should not be rescued by default
  # distances: :linear          # :spherical or :linear
)
