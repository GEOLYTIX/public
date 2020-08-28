# London

I live in London, UK.

Each *stanza* is a markdown file with a hidden script tag.

The script is evaluated to animate the map to the geographic coordinates for London.

<script>
map.getView().animate({
  center: ol.proj.fromLonLat([-0.2416802, 51.5287718]),
  zoom: 10,
  duration: 1000
});
</script>
