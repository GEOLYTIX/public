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
		ROUND(100*age_under_4/pop2018dec) as age_under_4, 
		ROUND(100*age_4_to_11/pop2018dec) as age_4_to_11, 
		ROUND(100*age_12_to_16/pop2018dec) as age_12_to_16, 
		ROUND(100*age_17_to_64/pop2018dec) as age_17_to_64, 
		ROUND(100*age_65_plus/pop2018dec) as age_65_plus 
		FROM
		${table(_)}
		WHERE ${qID(_)}=${id(_)};`;
	}
}