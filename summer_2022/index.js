window.onload = async () => {
    
    const host = document.head.dataset.dir

    const locale = await mapp.utils.xhr(`${host}/api/workspace/locale?locale=summer`)

    const layers = await mapp.utils.promiseAll(
        Array.from(["mapbox"]).map(layer => mapp.utils.xhr(`${host}/api/workspace/layer?locale=${locale.key}&layer=${layer}`))
    )

    const state = {}

    const map = mapp.Mapview({
        host: host,
        target: "map",
        locale: locale,
        scrollWheelZoom: true,
        attribution: {
            "© Mapbox": "https://www.mapbox.com/about/maps",
            "© OpenStreetMap contributors": "http://www.openstreetmap.org/copyright",
            "Geolytix MAPP 2022": "https://geolytix.co.uk/#mapp"
        }
    })

    await map.addLayer(
        layers.map(l => {
            l.display = true
            return l
    }))

    createStories()

    function createStories(){

        const xhr = new XMLHttpRequest()

        xhr.open('GET', 'https://geolytix.github.io/public/summer_2022/data.json')

        xhr.onload = e => {
            if(!e.target) return;
            if(!e.target.response) return;

            document.getElementById('stories').innerHTML = ''

            state.els = null

            if(!state.stories) state.stories = JSON.parse(e.target.response)

            Object.values(state.stories).map((story, i) => {

                let el = mapp.utils.html.node`<div class="story" data-lat=${story.lat} data-lng=${story.lng}>`

                let div = mapp.utils.html.node`<div style="text-align:right;">`

                story.images.map((image, j) => {
                    let img = mapp.utils.html.node`<img src="${image}" class="${j%2 === 0 ? `bottom` : `top`}">`
                    div.appendChild(img)
                })

                let card = mapp.utils.html.node`<div class="${story.card_on_top ? `card on_top` : `card`}">
                <h4>${story.place}</h4>
                <h2>${story.title}</h2>
                <p>${story.description}</p>
                <h3>${story.name}`

                el.appendChild(div)

                el.appendChild(card)
                
                document.getElementById('stories').appendChild(el)
            
            })

            state.els = Array.from(document.querySelectorAll('#stories div.story'))
            let elm = state.els.find(el => isInFocus(el)) // initialize map view
            let idx = state.els.indexOf(elm)
            state.prev = state.current
            state.current = idx < 0 ? 0 : idx

            let dataset = state.els[state.current].dataset
            
            setView({
                lat: parseFloat(dataset.lat),
                lng: parseFloat(dataset.lng)
            })

            if(state.current === 0) map.Map.getView().setZoom(locale.view.z)
        }

        xhr.send()

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
            let dataset = state.els[idx].dataset;
            if(!dataset) return;
            if(!dataset.lat || !dataset.lng) return 
            
            setView({
                lat: parseFloat(dataset.lat),
                lng: parseFloat(dataset.lng)
            })
        }

        if(state.current === 0) map.Map.getView().setZoom(locale.view.z)

    }, { passive: true })

    function isInFocus(el) {
        const rect = el.getBoundingClientRect()
        return rect.top > 0 && rect.top < window.innerHeight/3
    }

    function setView(location) {
        if(state.layer) map.Map.removeLayer(state.layer)
        if(!location.lat || !location.lng) return
        if(!location.pin) location.pin = "https://geolytix.github.io/public/summer_2022/postcard_pin.svg"

        let pnt = new ol.Feature({
            geometry: new ol.geom.Point([location.lng, location.lat]).transform('EPSG:4326', 'EPSG:'+ map.srid)
        })
        const source = new ol.source.Vector()
        source.addFeatures([pnt])

        state.layer = new ol.layer.Vector({
            source: source,
            style: mapp.utils.style({
                icon: {
                    svg: location.pin,
                    scale: 2
                }
            })
        })

        map.Map.addLayer(state.layer)

        map.fitView(source.getExtent())
    }



}