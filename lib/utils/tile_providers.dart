const apikey = '';

enum TileLayerProvider {
  openStreetMap(
    name: 'OpenStreetMap',
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  ),
  googleMap(
    name: 'Google Map',
    urlTemplate: 'https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
  ),
  googleSatellite(
    name: 'Google Satellite',
    urlTemplate: 'https://mt1.google.com/vt/lyrs=s&x={x}&y={y}&z={z}',
  ),
  googleHybrid(
    name: 'Google Hybrid',
    urlTemplate: 'https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}',
  ),
  stadiaAlidadeSmoothDark(
    name: 'Stadia Dark',
    urlTemplate:
        'https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png?api_key=$apikey',
  ),
  stadiaAlidadeSmoothLight(
    name: 'Stadia Light',
    urlTemplate:
        'https://tiles.stadiamaps.com/tiles/alidade_smooth/{z}/{x}/{y}{r}.png?api_key=$apikey',
  );

  const TileLayerProvider({
    required this.name,
    required this.urlTemplate,
  });

  final String urlTemplate;
  final String name;
}
