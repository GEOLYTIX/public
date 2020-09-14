module.exports = {
  render: _ => {

    function table(_){

        if(!_.layer.tables) return _.layer.table;

        let table = _.layer.tables[_.z];

        if(!table) {

          let zoomKeys = Object.keys(_.layer.tables);

          let z = _.z;

          if(z <= Math.min(...zoomKeys)) z = Math.min(...zoomKeys);

            if(z >= Math.max(...zoomKeys)) z = Math.max(...zoomKeys);

            table = _.layer.tables[z];

        }

        return table;
      }

      function qID(_){
        return _.layer.qID;
      }

      function id(_){
        return _.id;
      }

    return `SELECT
        sum(case
               when rpp.st_fascia='Aldi' then 1
               else 0
           end) as "Aldi",
         sum(case
               when rpp.st_fascia='Biedronka' then 1
               else 0
           end) as "Biedronka",
       sum(case
               when rpp.st_fascia='Kaufland' then 1
               else 0
           end) as "Kaufland",
       sum(case
               when rpp.st_fascia='Lidl' then 1
               else 0
           end) as "Lidl",
       sum(case
               when rpp.st_fascia='Netto' then 1
               else 0
           end) as "Netto",
       sum(case
               when rpp.st_fascia='Żabka' then 1
               else 0
           end) as "Żabka"
      FROM geodata.pol_glx_geodata_retail_points rpp
      inner join ${table(_)} sst on st_intersects(sst.geom_4326, rpp.geom_p_4326)
      where sst.${qID(_)}=${id(_)};`;
  }
}

