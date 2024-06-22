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
        'https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png',
  ),
  stadiaAlidadeSmoothLight(
    name: 'Stadia Light',
    urlTemplate:
        'https://tiles.stadiamaps.com/tiles/alidade_smooth_light/{z}/{x}/{y}{r}.png',
  ),
  stadiaAlidadeSmoothDarkLabels(
    name: 'Stadia Dark - Labels',
    urlTemplate:
        'https://tiles.stadiamaps.com/tiles/alidade_smooth_dark_labels/{z}/{x}/{y}{r}.png',
  ),
  stadiaAlidadeSmoothDarkNoLabels(
    name: 'Stadia Dark - No Labels',
    urlTemplate:
        'https://tiles.stadiamaps.com/tiles/alidade_smooth_dark_nolabels/{z}/{x}/{y}{r}.png',
  );

  const TileLayerProvider({
    required this.name,
    required this.urlTemplate,
  });

  final String urlTemplate;
  final String name;
}
