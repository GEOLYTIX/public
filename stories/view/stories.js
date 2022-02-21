window.onload = () => {
    _xyz({
        host: '/stories',
        hooks: false,
        locale: 'Stories',
        callback: _xyz => callback(_xyz)
    })
}


function callback(_xyz) {

    const state = {}

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

    createStories()


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

    })

    function createStoriesList(){
        if(!state.stories) return
        state.stories.map(name => {
            document.querySelector('.stories-list').appendChild(_xyz.utils.html.node`<li><a href="${`#${name}`}">${name}`)
        })
    }

    function createStories(){
        
        const hash = window.location.hash ? window.location.hash.substring(1) : false

        const xhr = new XMLHttpRequest()

        xhr.open('GET', 'https://geolytix.github.io/public/stories/data/stories.json')

        xhr.onload = e => {

            if(!e.target) return

            if(!e.target.response) return

            let json = JSON.parse(e.target.response),
                stories = hash && json[hash] ? json[hash] : json[Object.keys(json)[0]]

            document.querySelector('.stories').innerHTML = ''
            state.els = null

            if(!state.stories) {
                state.stories = Object.keys(json)
                createStoriesList()
            }

            stories.map((story, i) => {
                let el = _xyz.utils.html.node`<div class="${(i%2 ? 'dark' : 'lite') + ' align_c'}" data-story='${JSON.stringify(story.location)}'>
                ${story.profile ? _xyz.utils.html.node`<img style="height: 8em;" src="${story.profile}">` : ``}
                <h1>${story.title}</h1>
                <h3>${story.address}</h3><br><p class="align_l">${story.description}`
                document.querySelector('.stories').appendChild(el)
            })

            state.els = Array.from(document.querySelectorAll('.stories div'))

            let el = state.els.find(el => isInFocus(el)) // initialize map view
            let idx = state.els.indexOf(el)
            state.prev = state.current
            state.current = idx < 0 ? 0 : idx
            let view = JSON.parse(state.els[state.current].dataset.story)
            setView(view)
        }

        xhr.send()
    }


    function isInFocus(el) {

        const rect = el.getBoundingClientRect()
        
        return rect.top > 0 && rect.top < window.innerHeight/3 // one third to support mobile view
    }

    function setView(story) {

        if(state.layer) _xyz.map.removeLayer(state.layer)

        if(!story.pin) story.pin = "https://geolytix.github.io/MapIcons/aga/me_teal.svg"
        
        let pnt = new ol.Feature({
            geometry: new ol.geom.Point([story.lng, story.lat]).transform('EPSG:4326', 'EPSG:'+_xyz.mapview.srid)
        })

        const source = new ol.source.Vector()

        source.addFeatures([pnt])

        state.layer = new ol.layer.Vector({
            source: source,
            style: _xyz.utils.style({
                icon: {
                    svg: story.pin
                }
            })
        })

        _xyz.map.addLayer(state.layer)

        _xyz.mapview.flyToBounds(source.getExtent())

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


    window.addEventListener('hashchange', () => {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        })
        createStories()
        let el = document.querySelector('.stories-list')
        if(el.style.display == 'block') el.style.display = 'none'
    
    }, false)

    document.querySelector('.select-story').addEventListener('click', e => {
        e.stopPropagation()
        let el = document.querySelector('.stories-list')
        el.style.display = el.style.display == 'block' ? 'none' : 'block'
    })


}
