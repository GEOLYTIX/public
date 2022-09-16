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
        scrollWheelZoom: true
    })

    await map.addLayer(
        layers.map(l => {
            l.display = true
            return l
    }))

    createStories()

    function createStories(){
        
        mapp.utils.xhr({
            url: 'https://geolytix.github.io/public/summer_2022/data.json'
        }).then(data => {

            if(!e.target) return;

            if(!e.target.response) return;

            const json = JSON.parse(e.target.response)

            document.getElementById('stories').innerHTML = ''
            state.els = null

            if(!state.stories) state.stories = Object.values(json)
            
            stories.map((story, i) => {
                console.log({
                    story: story,
                    i: i
                })
            })


        })
    }

    //temporary
    //state.els = Array.from(document.querySelectorAll('#stories div'))

    /*document.addEventListener('scroll', () => {

        const el = state.els.find(el => isInFocus(el))

        const idx = state.els.indexOf(el)

        state.prev = state.current

        state.current = idx

        if(state.current === state.prev) {
            //no moving
            console.log('no moving')
        } else {
            if(!el) return
            console.log(el.outerHTML)
            //if(!state.els[idx]?.dataset?.story) return
            //let view = JSON.parse(state.els[idx].dataset.story)
            //setView(view)
        }

    }, { passive: true })*/

    function isInFocus(el) {
        const rect = el.getBoundingClientRect()
        return rect.top > 0 && rect.top < window.innerHeight/3
    }

    function setView(story) {}



}