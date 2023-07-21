    $( document ).ready(function(){
    
        $('#aiwquery').autocomplete({
            source: function (request, response) {
                        $.getJSON("https://cab.geschkult.fu-berlin.de/exist/apps/cab_db/cab_ids_json/aiw_id.json", function(data) {

                            response($.map(data.aiw, function (key, value) {
                                var $term = request.term;
                                var $key_str = key.word;
                                //alert($key_str);
                                //alert($term);
                                if ( $key_str.includes( $term ) )   { 
                                    return {
                                        label: key.word,
                                        value: key.word,
                                        ref: key.id
                                    };
                                }
                            }));
                        });
                    },
            
            select: function (event, ui) {
				    $(event.target).val(ui.item.label);
				    window.open("aiw.html?id=" + ui.item.ref, '_blank');
				    //window.location = "aiw.html?id=" + ui.item.value;
				    return false;
			},  
			
            close : function (event, ui) {
                    val = $("#comment").val();
                    $("#aiwquery").autocomplete( "search", val ); //keep autocomplete open searching the input again
                    return false;  
            },
            
            minLength: 2,
            delay: 100,
        });
    });
    
    function aiwAjaxCall() 
    {
        $.getJSON("aiw_id.json?term=" + $('#aiwquery').val(),
            function(data) {
            $.each(data.entry, function(k, v) {                
                    alert(k + ' : ' + v);
            });
        });        
    }