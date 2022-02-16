window.onload = () => {
    _xyz({
        host: '/stories',
        hooks: false,
        locale: 'Stories',
        callback: _xyz => callback(_xyz)
    })
}


function callback(_xyz) {

    const layers = ["Mapbox"]

    _xyz.mapview.create({
        target: document.getElementById('map'),
        scrollWheelZoom: true,
        attribution: {
            target: document.querySelector('#_Attribution'),
            links: {
                [`XYZ v${_xyz.version}`]: 'https://geolytix.github.io/xyz',
                Openlayers: 'https://openlayers.org'
            }
        }
    })    

    const state = {
        els: Array.from(document.querySelectorAll('.stories div'))
    }

    _xyz.layers.load(layers).then(layers => {

        layers.forEach(layer => {

            layer.show() 

            window.addEventListener('resize', () => {
                setTimeout(() => {
                    _xyz.map.updateSize()
                    Object.values(_xyz.layers.list).forEach(l => {
                        l.mbMap?.resize()
                    })
                }, 300)
            })
        })

        let view = JSON.parse(state.els[0].dataset.story) // initialize map view
        setView(view)
    })


    function isInFocus(el) {

        const rect = el.getBoundingClientRect()
        
        return rect.top > 0 && rect.top < window.innerHeight/3 // one third to support mobile view
    }

    function setView(story) {
        let pnt = new ol.Feature({
            geometry: new ol.geom.Point([story.lng, story.lat]).transform('EPSG:4326', 'EPSG:'+_xyz.mapview.srid)
        })

        const sourceVector = new ol.source.Vector()

        sourceVector.addFeatures([pnt])

        _xyz.mapview.flyToBounds(sourceVector.getExtent())

    }

    document.addEventListener('scroll', () => {

        const el = state.els.find(el => isInFocus(el))

        const idx = state.els.indexOf(el)

        state.prev = state.current

        state.current = idx

        if(state.current === state.prev) {
            //no moving
        } else {
            if(!el) return
            // move the map
            let view = JSON.parse(state.els[idx].dataset.story)
            setView(view)
        }

    }, { passive: true })


}
