    var getUrlParameter = function getUrlParameter(sParam) {
        var sPageURL = window.location.search.substring(1),
            sURLVariables = sPageURL.split('&amp;'),
            sParameterName,
            i;
        
        for (i = 0; isLessThan( i, sURLVariables.length ); i++) {
            sParameterName = sURLVariables[i].split('=');
        
            if (sParameterName[0] === sParam) {
                return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
            }
        }
    }; 
    
    function GenerateStaticCeremony( $ceremony )
    {
        var $ceremonytitle = 0;
        var $getceremony   = 0;
        var $paral         = 0;        
        var $location = "";
        
        if ( $ceremony == 'dron' ) {
            $ceremonytitle = "Drōn Yasht";
            $getceremony   = "0";
            $location = "Static_Dron/static_dron.xml";

        } else if ( $ceremony == 'yasna' ) {
            $ceremonytitle = "Yasna";
            $getceremony   = "2";
            $location = "Static_Yasna/static_yasna.xml";

        } else if ( $ceremony == 'yasnar' ) {
            $ceremonytitle = "Yasna Rapithwin";
            $getceremony   = "1";
            $location = "Static_YasnaR/static_yasnar.xml";

        } else if ( $ceremony == 'visperad' ) {
            $ceremonytitle = "Visperad";
            $getceremony   = "3";
            $location = "Static_Visperad/static_visperad.xml";

        } else if ( $ceremony == 'visperad-dh' ) {
            $ceremonytitle = "Visperad Do-Homast";
            $getceremony   = "4";
            $location = "Static_Visperad_DH/static_visperad_dh.xml";

        } else if ( $ceremony == 'videvdad' ) {
            $ceremonytitle = "Videvdad";
            $getceremony   = "5";
            $location = "Static_Videvdad/static_videvdad.xml";

        } else if ( $ceremony == 'vishtasp' ) {
            $ceremonytitle = "Vishtasp Yasht";
            $getceremony   = "6";
            $location = "Static_Vishtasp/static_vishtasp.xml";    

        }
        
        PreGenerateDetails();
       
        $('#display-viewer').html("<p style='padding:40px'>Static " + $ceremonytitle + " is loading... Please wait " +
                                  '<i class="fa fa-circle-o-notch fa-spin"/>' + '</p>'
                                 );
        
        var $link = "";
        $link = $link.concat("https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/static_generator.xql?ceremony=", $getceremony );

        // close all open popovers
        $('div.popover').remove();
        
        $('#modalword').dialog('close');
        $('#modalnerang').dialog('close');
        $('#modalparallel').dialog('close');
    
        $.get( "https://cab.geschkult.fu-berlin.de/exist/apps/cab_db/cab_statics/" + $location, function (data) {
            
            SetTitles( $ceremonytitle );
            $('.btn-ceremony').prop('disabled', false);
            $('.btn-ceremony-paral').prop('disabled', false);

            var $val_data = xmlToString(data);
            $('#display-viewer').html( $val_data );

            $val_data = $val_data.replace( /but0/g, "but1" );           // update buttons
            $val_data = $val_data.replace( /paral0/g, "paral1" );           // update buttons
            $('#paral-viewer').html( $val_data );

            $('#mega-selector').collapse(); 
            $('#main_button').css('display','block');
                 
            CreateNavbar( $ceremonytitle, $getceremony );
            $('.tabcontent').first().css('display', 'block');      // load first element
        });

        GetDescription( $getceremony, 0 );
        
        $('[data-toggle="popover"]').popover({container: 'body', html: true});

    };    
    
    function CreateStaticCeremony( $ceremony )
    {
        var $ceremonytitle = 0;
        var $getceremony   = 0;
        var $roz           = 0;  
        var $mah           = 0;
        var $gah           = 0;
        var $dedicatory    = 0;
        var $paral         = 0;        
        
        if ( $ceremony == 'dron' ) {
            $ceremonytitle = "Drōn Yasht";
            $getceremony   = "0";
            $roz           = "1";  
            $mah           = "1";
            $gah           = "0";
            $dedicatory    = "1";

        } else if ( $ceremony == 'yasna' ) {
            $ceremonytitle = "Yasna";
            $getceremony   = "2";
            $roz           = "1";  
            $mah           = "1";
            $gah           = "0";
            $dedicatory    = "54";

        } else if ( $ceremony == 'yasnar' ) {
            $ceremonytitle = "Yasna Rapithwin";
            $getceremony   = "1";
            $roz           = "1";  
            $mah           = "1";
            $gah           = "1";
            $dedicatory    = "39";

        } else if ( $ceremony == 'visperad' ) {
            $ceremonytitle = "Visperad";
            $getceremony   = "3";
            $roz           = "12";  
            $mah           = "2";
            $gah           = "0";
            $dedicatory    = "42";

        } else if ( $ceremony == 'videvdad' ) {
            $ceremonytitle = "Videvdad";
            $getceremony   = "4";
            $roz           = "1";  
            $mah           = "1";
            $gah           = "4";
            $dedicatory    = "19";

        } else if ( $ceremony == 'vishtasp' ) {
            $ceremonytitle = "Vishtasp Yasht";
            $getceremony   = "5";
            $roz           = "1";  
            $mah           = "1";
            $gah           = "4";
            $dedicatory    = "26";

        }
        
        PreGenerateDetails();
       
        $('#display-viewer').html("<p style='padding:40px'>Static " + $ceremonytitle + " is loading... Please wait " +
                                  '<i class="fa fa-circle-o-notch fa-spin"/>' + '</p>'
                                 );
        
        var $link = "";
        $link = $link.concat("https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/ceremony_generator.xql?ceremony=", $getceremony , "&amp;paral=" , $paral , "&amp;gah=", $gah, "&amp;mah=", $mah, "&amp;roz=", $roz, "&amp;dedicatory=", $dedicatory );
        
        $link = $link.replace('amp;','');
        $link = $link.replace('amp;','');
        $link = $link.replace('amp;','');
        $link = $link.replace('amp;','');
        $link = $link.replace('amp;',''); // to replace this hack at one point

        // close all open popovers
        $('div.popover').remove();
        
        $('#modalword').dialog('close');
        $('#modalnerang').dialog('close');
        $('#modalparallel').dialog('close');
    
        $.ajax({
                    
            url: $link,
            async: true,
            
            success: function( data ) {
                 SetTitles( $ceremonytitle );
                 $('.btn-ceremony').prop('disabled', false);
                 $('.btn-ceremony-paral').prop('disabled', false);

                 var $val_data = xmlToString(data);
                 $('#display-viewer').html( $val_data );
                // $("ab1").css("display", "none");
                // $("ab2").css("display", "none");
                 //$("note").css("display", "none");

                 $val_data = $val_data.replace( /but0/g, "but1" );           // update buttons
                 $val_data = $val_data.replace( /paral0/g, "paral1" );           // update buttons
                 $('#paral-viewer').html( $val_data );

                 $('#mega-selector').collapse(); 
                 $('#main_button').css('display','block');
                 
                 CreateNavbar( $ceremonytitle, $getceremony );
                 $('.tabcontent').first().css('display', 'block');      // load first element
            },
            
            type: "GET",
            processData: false,  // tell jQuery not to process the data
            contentType: false   // tell jQuery not to set contentType
                       
        }).done(function( data ) {
                console.log( data );
        });                         

        GetDescription( $getceremony, 0 );
        
        $('[data-toggle="popover"]').popover({container: 'body', html: true});

    };
    
    function GetDescription( $getceremony, $paral )
    {
        $description = "";
        $description = $description.concat("https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/get_description.xql?ceremony=", $getceremony );

        $.ajax({
            url: $description,
            async: true,
            
            success: function( data ) {
                 var $val_data = xmlToString(data);
                 if ( $paral ) {
                    $('#stanza-modal-paral').html( $val_data );
                 } else {
                    $('#stanza-modal').html( $val_data );
                    $('#stanza-modal-paral').html( $val_data );
                 }
            },
            
            type: "GET",
            processData: false,  // tell jQuery not to process the data
            contentType: false   // tell jQuery not to set contentType
                       
        }).done(function( data ) {
                console.log( data );
        });   
    }