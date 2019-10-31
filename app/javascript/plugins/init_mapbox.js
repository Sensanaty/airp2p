import mapboxgl from 'mapbox-gl'

const initMapbox = () => {
    const mapElement = document.querySelector("#map");

    const fitMapToMarkers = (map, markers) => {
        const bounds = new mapboxgl.LngLatBounds();
        markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
        map.fitBounds(bounds, { padding: 50, maxZoom: 20, duration: 0 });
    };

    if (mapElement) {
        mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
        const map = new mapboxgl.Map({
            container: 'map',
            style: 'mapbox://styles/sensanaty/ck2cvfbed0toh1cmtnquioc26'
        });

        const markers = JSON.parse(mapElement.dataset.markers);
        markers.forEach((marker) => {
            const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

            new mapboxgl.Marker()
                .setLngLat([ marker.lng, marker.lat ])
                .setPopup(popup)
                .addTo(map);
        });

        fitMapToMarkers(map, markers);
    }
};

export { initMapbox }