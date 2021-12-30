# Mexico City

Here we go to Mexico City where I used to live and work.

The map is done with the [OpenLayers](https://openlayers.org/), an OpenSource library for interactive web maps.

The map data is from [OpenStreetMap contributors](https://www.openstreetmap.org/copyright).

```javascript
map.getView().animate({
  center: ol.proj.fromLonLat([-99.4238064,19.390519]),
  zoom: 10,
  duration: 3000
});
```

<script>
map.getView().animate({
  center: ol.proj.fromLonLat([-99.4238064,19.390519]),
  zoom: 10,
  duration: 3000
});
</script>
