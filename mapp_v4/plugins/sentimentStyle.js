const xmlSerializer = new XMLSerializer()

const sentimentColour = {
  0: "#00ac5d",
  25: "#89c92d",
  50: "#feb000",
  75: "#ff7700",
  100: "#e80030"
};

export default (function(){

  mapp.utils.svgSymbols.sentimentIcon = (theme, feature) => {

    let F = feature.getProperties()

    // const icon = mapp.utils.svg.node`
    // <svg width=24 height=24 viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg'>
    //   <circle cx=12 cy=12 r=10 fill=${sentimentColour[F.properties.sentiment] || '#fff'}></circle>`

    const icon = mapp.utils.svg.node`
      <svg width="30" height="30" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg">
        <g filter="url(#a)">
          <circle cx="15" cy="15" r="10" fill=${sentimentColour[F.properties.sentiment] || '#fff'}></circle>
        </g>
        <defs>
          <filter id="a" x="0" y="0" width="100" height="100" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
            <feFlood flood-opacity="0" result="BackgroundImageFix"/>
            <feColorMatrix in="SourceAlpha" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
            <feOffset dx="2" dy="2"/>
            <feGaussianBlur stdDeviation="1"/>
            <feComposite in2="hardAlpha" operator="out"/>
            <feColorMatrix values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"/>
            <feBlend in2="BackgroundImageFix" result="effect1_dropShadow_64_3"/>
            <feBlend in="SourceGraphic" in2="effect1_dropShadow_64_3" result="shape"/>
          </filter>
        </defs>
      </svg>`

    return `data:image/svg+xml,${encodeURIComponent(xmlSerializer.serializeToString(icon))}`

  }

  mapp.plugins.sentimentCluster = (layer) => {

    layer.styleFunction = (feature) => {

      let features = feature.get("features");
  
      return features.length === 1 ? singleStyle(feature) : clusterStyle(feature);

    }

    layer.L.setStyle(layer.styleFunction)
  }

  const memoizedStyles = {};

  function singleStyle(feature) {

    let highlight = feature.get("highlight");
  
    let features = feature.get("features");
  
    let colour = sentimentColour[features[0].getProperties().properties.sentiment];
  
    if (memoizedStyles[colour]) {
      return memoizedStyles[colour];
    }
  
    let icon = mapp.utils.svg.node`
          <svg width=24 height=24 viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg'>
            <circle cx=12 cy=12 r=12 fill=${colour}></circle>`;
  
    let style = new ol.style.Style({
      image: new ol.style.Icon({
        src: `data:image/svg+xml,${encodeURIComponent(
          xmlSerializer.serializeToString(icon)
        )}`,
        scale: (highlight && 2) || 1,
        anchor: [0.5, 0.5]
      })
    });
    
    memoizedStyles[colour] = style;
  
    return style;
  }
  
  function clusterStyle(feature) {

    let highlight = feature.get("highlight");
  
    let features = feature.get("features");
  
    let clusterSentiment = {
      0: 0,
      25: 0,
      50: 0,
      75: 0,
      100: 0
    };
  
    for (let i = 0; i < features.length - 1; i++) {
      clusterSentiment[features[i].getProperties().properties.sentiment]++;
    }
  
    let clusterSentimentString = JSON.stringify(clusterSentiment);
  
    if (!highlight && memoizedStyles[clusterSentimentString]) {
      return memoizedStyles[clusterSentimentString];
    }
  
    let start = 0;
  
    let icon = mapp.utils.svg.node`
          <svg width=24 height=24 viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg'>
            <circle cx=12 cy=12 r=12 fill='#555'></circle>`;
  
    Object.entries(clusterSentiment).map((sentVal) => {
      if (sentVal[1]) {
        let segment = (sentVal[1] / (features.length - 1)) * 100;
  
        icon.appendChild(mapp.utils.svg.node`
              <path
                d=${createSvgArc([12, 12], 12, [start, segment - 0.01])}
                fill=${sentimentColour[sentVal[0]]}/>`);
  
        start = start + segment;
      }
    });
  
    icon.appendChild(mapp.utils.svg.node`
          <circle cx=12 cy=12 r=8 fill='#fff'></circle>`);

    let style = new ol.style.Style({
      image: new ol.style.Icon({
        src: `data:image/svg+xml,${encodeURIComponent(
          xmlSerializer.serializeToString(icon)
        )}`,
        scale: (highlight && 3) || 2,
        //scale: 2,
        anchor: [0.5, 0.5]
      }),
      text: new ol.style.Text({
        font: "16px sans-serif",
        text: String(features.length),
        fill: new ol.style.Fill({
          color: "#000"
        })
      })
    });

    if (highlight) return style;
  
    memoizedStyles[clusterSentimentString] = style
  
    return style;
  }
    
  function createSvgArc([cx, cy], r, [start, sweep], φ = -1.5708) {
    let t1 = start * 0.062831853071796;
  
    let Δ = sweep * 0.062831853071796;
  
    /*
        cx,cy → center of ellipse
        r → radius
        t1 → start angle, in radian.
        Δ → angle to sweep, in radian. positive.
        φ → rotation on the whole, in radian
        URL: SVG Circle Arc http://xahlee.info/js/svg_circle_arc.html
      */
  
    const cos = Math.cos;
    const sin = Math.sin;
    const π = Math.PI;
  
    const f_matrix_times = ([[a, b], [c, d]], [x, y]) => [
      a * x + b * y,
      c * x + d * y
    ];
    const f_rotate_matrix = (x) => [
      [cos(x), -sin(x)],
      [sin(x), cos(x)]
    ];
    const f_vec_add = ([a1, a2], [b1, b2]) => [a1 + b1, a2 + b2];
  
    Δ = Δ % (2 * π);
    const rotMatrix = f_rotate_matrix(φ);
    const [sX, sY] = f_vec_add(
      f_matrix_times(rotMatrix, [r * cos(t1), r * sin(t1)]),
      [cx, cy]
    );
    const [eX, eY] = f_vec_add(
      f_matrix_times(rotMatrix, [r * cos(t1 + Δ), r * sin(t1 + Δ)]),
      [cx, cy]
    );
    const fA = Δ > π ? 1 : 0;
    const fS = Δ > 0 ? 1 : 0;
  
    return [
      "M",
      cx,
      cy,
      "L",
      sX,
      sY,
      "A",
      r,
      r,
      (φ / (2 * π)) * 360,
      fA,
      fS,
      eX,
      eY,
      "L",
      cx,
      cy
    ].join(" ");
  }

})()
