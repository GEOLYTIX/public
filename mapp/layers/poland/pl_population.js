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
		pop2018dec, 
		pop2017dec, 
		pop2016dec, 
		pop2015dec, 
		pop2014dec, 
		pop2013dec, 
		pop2012dec 
		FROM 
		${table(_)}
		WHERE ${qID(_)}=${id(_)};`;
	}
}