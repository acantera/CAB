$( document ).ready(function() {

    function getUrlParameter(sParam) {
        var sPageURL = window.location.search.substring(1),
            sURLVariables = sPageURL.split('&'),
            sParameterName,
            i;
    
        for (i = 0; i < sURLVariables.length; i++) {
            sParameterName = sURLVariables[i].split('=');
    
            if (sParameterName[0] === sParam) {
                return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
            }
        }
    };
    

    $(document.body).on('mouseenter', 'rdg' ,function(){
        $( this ).css( 'cursor', 'pointer' );
        var $correct_form = $( this ).next().html();
        $('#box_correct').html( $correct_form );
        $('#box_correct').css({top: event.pageY - 44, left: event.clientX + 16}).show();
       
    });
    
    $(document.body).on('mouseleave', 'rdg' ,function(){
        $("#box_correct").hide();
    });
    
    $(document.body).on('mouseenter', 'abbr', function(){ 
            var $form = "";

            $( this ).css( 'cursor', 'pointer' );
            var $abbrev = $( this ).html();
            var $left  = '0';
            var $right = '0';
            
            if ( $( this ).prev().html() )  {
                if ( $( this ).prev().prop("tagName").toLowerCase() == "abbr" ) {
                    $left = $( this ).prev().text();
                }   
            }
            
            if ( $( this ).next().html() )  {
                if ( $( this ).next().prop("tagName").toLowerCase() == "abbr" ) {
                    $right = $( this ).next().text();
                   
                }   
            }

            var $link = "";
            $link = $link.concat('https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/get_abbrev.xql?abbrev=', $abbrev, '', '&amp;left=', $left, '' ,'&amp;right=', $right );
            $link = $link.replace('amp;','');
            $link = $link.replace('amp;','');
            
            var $correct_abbrev = "";

            $.ajax({
                    
                url: $link,
                async: false,
                success: function( data ) {
                    $form = xmlToString(data);
                },
                
                type: "GET",
                processData: false,  // tell jQuery not to process the data
                contentType: false   // tell jQuery not to set contentType
                           
            }).done(function( data ) {
                //console.log( data );
            });        

            $correct_abbrev = $form;

            $('#box_correct').html( $correct_abbrev );
            $('#box_correct').css({top: event.pageY + 10, left: event.clientX + 4}).show();
    });    
    
    $(document.body).on('mouseleave', 'abbr' ,function(){
        $("#box_correct").hide();
    });
        
    //get rid of extra spaces for instant load
    var $fulltext  = $('#manuscript_viewer').html();
    $fulltext = $fulltext.replace(/ +(?= )/g,'');       // remove duplicates spaces
    $fulltext = $fulltext.replace(/(\r\n|\n|\t)/g,'');  // remove end lines, special characters etc
    $fulltext = $fulltext.replace(/ <lb/g,'<lb');       // remove space between text and line break
    $fulltext = $fulltext.replace(/ <pb/g,'<pb');       // remove space between text and line break

    $( '#manuscript_viewer' ).html( $fulltext );
    

    $(document.body).on('change', '#get-type', function (e) {
            var $folder = $(this).val();
            var $link = "";
            $link = $link.concat('https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/get_manuscripts.xql?type=', $folder );

            var $form = "";

            $.ajax({
                    
                url: $link,
                async: false,
                success: function( data ) {
                    $form = xmlToString(data);
                },
                
                type: "GET",
                processData: false,  // tell jQuery not to process the data
                contentType: false   // tell jQuery not to set contentType
                           
            }).done(function( data ) {
                //console.log( data );
            });        
            
            $( '#get-no' ).children().remove().end().append('<option value="0"/>');  
            
            $( $form ).find( 'option' ).each (function() {
                var o = new Option( $(this).html(), $(this).html() );
                $('#get-no').append(o);
            });
           
    });
    
    function PopulateNavigator()
    {
        $( '#nav_ceremony_title' ).text( $( '#manuscript-title' ).text() ); // set title
        
        $.each( $('#manuscript_viewer').find( 'pb' ), function() {     
            $( '#page_navigator' ).append( '<h4 id="nav_ceremony_header">' +
                                                '<a href="#' + $( this ).attr( 'n' ) + '" style="font-size:14px">' +
                                                '<span class="glyphicon glyphicon-play" style="font-size:11px"/> ' +
                                                $( this ).attr( 'n' )
                                                + '</a></h4>');
        });
        
        
        var $current = 0;
        var $todo = 0;
        
        $.each( $('#manuscript_viewer').find( 'b' ), function() {     
            $id = $( this ).text();
            
            
            if ( $id.indexOf( '.' ) >= 0 ) {
                $id = $id.replace( ': ', '' );
                $todo = $id.substr( 0, $id.indexOf( '.' ) ) 
                
                if ( $todo != $current )    {
                    $current = $todo;
                    $( '#man_navigator' ).append( '<a href="#/" data-toggle="collapse" data-target="#list' + $current +                         '">' + 
                                                '<h4 id="nav_ceremony_header">' +
                                                '<span class="glyphicon glyphicon-chevron-down" style="font-size:11px"/> ' +
                                                 $current
                                                + '</h4></a>');
                    $( '#man_navigator' ).append('<div id="list' + $current 
                                                + '" class="collapse" aria-expanded="true">' 
                                                + '<ul id="li' + $current + '"/>' 
                                                + '</div>' );
                    $('#li' + $current ).append('<li>' 
                                            + '<a href="#' + $id + '" >' + '<span class="glyphicon glyphicon-play"/>'
                                            + ' ' + $id + '</a>'
                                            + '</li>');                                                
                } else {
                
                     $( '#li' + $current ).append('<li>' 
                                         + '<a href="#' + $id + '">' 
                                         + '<span class="glyphicon glyphicon-play"/>'
                                             + ' ' + $id
                                             + '</a></li>');
                
                }
                
            }
                                                
        });
        GoTo( '1' ); 
        $( '#navig-bar' ).show();
    }


    function CreateNavigation()
    {
        PopulateNavigator();        
        
        // remove double and triple etc spaces
        var $fulltext  = $('#manuscript_box_translit').html();
        $fulltext = $fulltext.replace(/ +(?= )/g,'');       // remove duplicates spaces
        $fulltext = $fulltext.replace(/(\r\n|\n|\t)/g,'');  // remove end lines, special characters etc
        $fulltext = $fulltext.replace(/ <lb/g,'<lb');       // remove space between text and line break
        $fulltext = $fulltext.replace(/ <pb/g,'<pb');       // remove space between text and line break

        $fulltext = $fulltext.replace(/<pb n="(\d+\w)/g,'<pb id="$1" n="$1');       // to allow navigation
        $fulltext = $fulltext.replace(/xml:id/g,'id');       // to allow navigation

        $('#manuscript_box_translit').html( $fulltext );
    }

    function getManuscripts()
    {
        $( '#navig-bar' ).hide();
        
        var $folder = $( '#get-type' ).val();
        var $no = $( '#get-no').val();
        var $link = "";
                                                         
        $link = $link.concat('https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/get_manuscripttranslit.xql?manuscript=', $folder, '/', $no );   
        var $manuscript = "";
        
        $.ajax({
                  
            url: $link,
            async: false,
            success: function( data ) {
                $manuscript = xmlToString(data);

            },
        
            type: "GET",
            processData: false,  // tell jQuery not to process the data
            contentType: false   // tell jQuery not to set contentType
                              
        }).done(function( data ) {
            $('#display-viewer').html("");
        });     
        
        $('#manuscript_box_translit').replaceWith( $manuscript );    

        CreateNavigation();

        // populate passages
            $folder = $( '#get-type' ).val();
            $link = "";
            $link = $link.concat('https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/get_passages.xql?no=', $folder ,'/', $no );

            var $form = "";

            $.ajax({
                    
                url: $link,
                async: false,
                success: function( data ) {
                    $form = xmlToString(data);
                },
                
                type: "GET",
                processData: false,  // tell jQuery not to process the data
                contentType: false   // tell jQuery not to set contentType
                           
            }).done(function( data ) {
                $('#display-viewer').html("");
            });     
        
        
        
        $( '#get-passage' ).children().remove().end().append('<option value="0">Full manuscript</option>');  
            
        $( $form ).find( 'option' ).each (function() {
            var o = new Option( $(this).html(), $(this).html() );
            $('#get-passage').append(o);
        });
        
    };
    
    $(document.body).on('change', '#get-no', function (e) {
        $('#display-viewer').html("<p>" + "Retrieving transliteration " 
                                        + '<i class="fa fa-circle-o-notch fa-spin"/>' + "</p>"
                                 );
    
        setTimeout(function() {         // fix weird chrome issue
            getManuscripts();
        }, 1000);
        

    });
        
    $(document.body).on('change', '#get-passage', function (e) {
        $('#display-viewer').html("<p>" + "Retrieving transliteration " 
                                        + '<i class="fa fa-circle-o-notch fa-spin"/>' + "</p>"
                                 );

        setTimeout(function() {         // fix weird chrome issue
            getPassages();
        }, 1000);
        
    });        
        
        
    function getPassages()
    {
        $( '#navig-bar' ).hide();
        
        var $folder = $( '#get-type' ).val();
        var $no = $( '#get-no' ).val();
        var $passage = $( '#get-passage' ).val();
        
        if  ( $passage == "0" ) {
            getManuscripts();
            return;
        }

        
        var $link = "";
        $link = $link.concat('https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/get_passagestranslit.xql?folder=', $folder, '/', $no, '&amp;passage=', $passage );   
        $link = $link.replace('amp;','');
       
        var $manuscript = "";
        
        $.ajax({
                  
            url: $link,
            async: false,
            success: function( data ) {
                $manuscript = xmlToString(data);
            },
        
            type: "GET",
            processData: false,  // tell jQuery not to process the data
            contentType: false   // tell jQuery not to set contentType
                              
        }).done(function( data ) {
                $('#display-viewer').html("");
        });     
        
        $('#manuscript_box_translit').replaceWith( $manuscript );    
    
        // remove double and triple etc spaces
        var $fulltext  = $('#manuscript_box_translit').html();
        $fulltext = $fulltext.replace(/ +(?= )/g,'');       // remove duplicates spaces
        $fulltext = $fulltext.replace(/(\r\n|\n|\t)/g,'');  // remove end lines, special characters etc
        $fulltext = $fulltext.replace(/ <lb/g,'<lb');       // remove space between text and line break
        $fulltext = $fulltext.replace(/ <pb/g,'<pb');       // remove space between text and line break

        $('#manuscript_box_translit').html( $fulltext );
        
    };

    if ( $( 'pb' ).length > 0 ) {       // for directly loaded manuscripts
        CreateNavigation();
    } else {
        $( '#navig-bar' ).hide();
    }

});