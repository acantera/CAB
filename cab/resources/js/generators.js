    function GenerateKhordehCeremony()
    {
        var $getceremony = $('#get-ceremony-khordeh').children(':selected').attr('value');
        var $gah         = $('#gah-khordeh').children(':selected').attr('value');
        var $gah_off      = $('#gah-khordeh').is(':enabled');
        var $type        = $('#type-khordeh').children(':selected').attr('value');
        
        var $shorttitle    = $('#get-ceremony-khordeh option:selected').text() + (parseInt($('#get-ceremony-khordeh').children(':selected').attr('value')) + 1);
        var $ceremonytitle = $('#get-ceremony-khordeh option:selected').text() + " " + $('#type-khordeh option:selected').text();

        Deselect();

        if ( $getceremony == -1 ) {
            custom_alert("Please select a ceremony");
            return;
        }
          
        if ( $type < 1 )  {
            custom_alert("Please select a ceremony type");
            return;
        }

        if ( ( $gah == -1 ) && ( $gah_off ) )   {
            custom_alert("Please select a Gah");
            return;
        }   

        PreGenerateKhordehDetails();
        
        $('#display-viewer').html("<p>" + $ceremonytitle + " is being generated... Please wait "
                                        + '<i class="fa fa-circle-o-notch fa-spin"/>' + '</p>'
                                 );

        var $link = "";
        $link = $link.concat("https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/ceremony_generator_khordeh.xql?ceremony=", $getceremony , "&amp;type=" , $type, "&amp;gah=" , $gah );
        
        $link = $link.replace('amp;','');
        $link = $link.replace('amp;','');
        $link = $link.replace('amp;','');

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
                // $('.btn-ceremony-paral').prop('disabled', false);

                 var $val_data = xmlToString(data);
                 $('#display-viewer').html( $val_data );

                 //$val_data = $val_data.replace( /but0/g, "but1" );           // update buttons
                 //$val_data = $val_data.replace( /paral0/g, "paral1" );           // update buttons
                 //$('#paral-viewer').html( $val_data );

                 $('#mega-selector').collapse(); 
                 $('#main_button').css('display','block');
                 
                    if ( $getceremony >= 6 ) {
                        CreateNavbar( $ceremonytitle, $ceremonytitle );
                    } else {
                        CreateKhordehNavbar( $shorttitle, $ceremonytitle );     
                    }
                   
                // CreateParalNavbar( $ceremonytitle, $getceremony );
                  // $('.tabcontent').first().css('display', 'block');      // load first element when starting in stanza view
                 
            },
            
            type: "GET",
            processData: false,  // tell jQuery not to process the data
            contentType: false   // tell jQuery not to set contentType
                       
        }).done(function( data ) {
                console.log( data );
        });         
        
        GetDescription( $getceremony, 0 );
        
        
    }
    
    function AjaxCall( url, callback ) {
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == XMLHttpRequest.DONE && xmlhttp.status == 200) {
                var data = xmlhttp.responseText;
                if (callback) callback(data);
            }
        };
  
        xmlhttp.open( "GET", url, true );
        xmlhttp.send();
    }    
    
    function FastHtml( el, html ) {
	    var oldEl = typeof el === "string" ? document.getElementById(el) : el;
	
	    var newEl = oldEl.cloneNode(false);
	    newEl.innerHTML = html;
	    oldEl.parentNode.replaceChild(newEl, oldEl);
	
    };    
    
    function GenerateCeremony()
    {
        var $ceremonytitle = $('#get-ceremony option:selected').text();
        var $getceremony = $('#get-ceremony').children(':selected').attr('value');
        var $roz         = $('#roz').children(':selected').attr('value');  
        var $mah         = $('#mah').children(':selected').attr('value');
        var $gah         = $('#gah').children(':selected').attr('value');
        var $dedicatory  = $('#dedicatory').children(':selected').attr('value');
        var $paral       = 0;

        Deselect();
        SyncParal( $getceremony, $roz, $mah, $gah, $dedicatory );
        
        if ( $getceremony == -1 ) {
            custom_alert("Please select a ceremony");
            return;
        }
        
         if ( $roz == 0 )   {
            custom_alert("Please select a day");
            return;
        }   

        if ( ( $mah == 0 ) || ( $mah == -1 ) )   {
            if ( ! ["31", "32", "33", "34", "35"].includes($roz) )  {
                custom_alert("Please select a month");
                return;
            }
        }        

        if ( $dedicatory == 0 )   {
            
            if ( $getceremony != 9 )    {
                custom_alert("Please select a dedicatory");
                return;
            }
        }
        
        if ( $gah == -1 )   {
            custom_alert("Please select a Gah");
            return;
        }     


        var $gahanbar_error = "The selected date is not a Gāhānbār" + "<br/>" +
                            "The following are the six Gāhānbār feasts:" + 
                            "<br/>" + "<br/>" +
                            "Maidyozarem: 11th to the 15th of the second month" + "<br/>" +
                            "Maidyoshahem: 11th to the 15th of the fourth month"+ "<br/>" +
                            "Paitishahem: 26th to the 30th of the sixth month"  + "<br/>" +
                            "Ayathrem: 26th to the 30th of the seventh month"   + "<br/>" +
                            "Maidyarem: 16th to the 20th of the tenth month"    + "<br/>" +
                            "Hamaspathmaidyem: 26th to the 30th of the twelfth month" + "<br/>" +
                            "plus the 5 Gatha days";

        var $only_gahanbar = "Only a dedicatory to Gāhānbār is possible on this date";   
        var $only_frawardigan = "A dedicatory to the Fravashis is only possible on the last ten days of the year and on Frawardīgān";

        if ( ["0","3"].includes( $getceremony ) )   {
            if ( $dedicatory != 42 )  {
                if ( ["2", "4"].includes( $mah) ) {
                    if ( ["11","12","13","14","15"].includes($roz) ) {       
                        custom_alert($only_gahanbar);
                        return;  
                    }
                    
                } else if ( ["6", "7"].includes($mah) ) {
                    if ( ["26","27","28","29","30"].includes($roz) ) {    
                        custom_alert($only_gahanbar);
                        return;  
                    }
                
                } else if ( ["10"].includes($mah) ) {
                    if ( ["16","17","18","19","20"].includes($roz) ) {    
                        custom_alert($only_gahanbar);
                        return;  
                    }
                    
                } else if ( ["12"].includes($mah) ) {
                    if ( ["26","27","28","29","30"].includes($roz) ) {     
                        if ( $dedicatory != 21 ) {
                            custom_alert($only_gahanbar);
                            return;
                        }
                    }
                }            
                
            }
            
        }

        if ( $dedicatory == 21 ) {

            if ( ["12"].includes($mah) ) {
                if ( ! ["26","27","28","29","30"].includes($roz) ) {     
                    custom_alert($only_frawardigan);
                    return;
                }
            
            } else if ( ["0"].includes($mah) ) {
            
                if ( ! ["31", "32", "33", "34", "35"].includes($roz) ) {    
                    custom_alert($only_frawardigan);
                    return;
                }
                
            } else if ( ["1"].includes($mah) ) {
                if ( ! ["1"].includes($roz) ) {    
                    custom_alert($only_frawardigan);
                    return;
                }
                
            } else {
                custom_alert($only_frawardigan);
                return;
            }
            
        }
        
        if ( $dedicatory == 42) {
            if ( ["2", "4"].includes( $mah) ) {
                if ( ! ["11","12","13","14","15"].includes($roz) ) {       
                    custom_alert($gahanbar_error);
                    return;  
                }
                    
            } else if ( ["6", "7"].includes($mah) ) {
                if ( ! ["26","27","28","29","30"].includes($roz) ) {    
                    custom_alert($gahanbar_error);
                    return;  
                }
                
            } else if ( ["10"].includes($mah) ) {
                if ( ! ["16","17","18","19","20"].includes($roz) ) {    
                    custom_alert($gahanbar_error);
                    return;  
                }
                    
            } else if ( ["12"].includes($mah) ) {
                if ( ! ["26","27","28","29","30"].includes($roz) ) {     
                    custom_alert($gahanbar_error);
                    return;
                }
            
            } else if ( ["0"].includes($mah) ) {
            
                if ( ! ["31", "32", "33", "34", "35"].includes($roz) ) {    
                    custom_alert($gahanbar_error);
                    return;
                }
                    
            } else {
                custom_alert($gahanbar_error);
                return;               
            }
                
        }
        
        //if ( isLessThan(  12, parseInt( $roz ) ) )    {
        //    $mah = 12 + ( parseInt($roz) - 30 );
        //}  // ???
        
        PreGenerateDetails();
            
        var $ceremonies = ["Dron Yasht", "Yasna Rapithwin", "Yasna", "Visperad", "Videvdad", "Vishtasp Yasht", "", "", "", "Homast Paragna", "Paragna", "Visperad Do-Homast" ];   
        var $gahs       = ["Hawan", "Rapithwin", "Uzerin", "Aiwisruthrem", "Ushahin"];
        
        $('#display-viewer').html("<p>" + $ceremonies[$getceremony] + ", " + $gahs[$gah] + " Gah is being generated... Please wait "
                                        + '<i class="fa fa-circle-o-notch fa-spin"/>' + '</p>'
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
                

        AjaxCall( $link, function ( data )  {
                
            FastHtml( 'display-viewer', data);

            SetTitles( $ceremonytitle );
            
            $('.btn-ceremony').prop('disabled', false);
            $('#mega-selector').collapse(); 
            $('#main_button').css('display','block');
                 
            data = data.replace( /but0/g, "but1" );           // update buttons
            data = data.replace( /paral0/g, "paral1" );       // update buttons
            
            FastHtml( 'paral-viewer', data);
            
            CreateNavbar( $ceremonytitle, $getceremony );
            CreateParalNavbar( $ceremonytitle, $getceremony );

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
    
    function PreGenerateparal()
    {
        $('#right-nav').css('visibility', 'hidden');
        CloseModal( 2 );
        CloseParalNav();
        $('#see_paral').css('display', 'none');
        $('#paral-viewer').find('.butpopall').css('display','none');
        $('#paral-viewer').find('.butpopall').attr('value', 0); 
        $('#ceremony_paral_nav_menu').html('');
        $('.btn-ceremony').prop('disabled', true);
        $('.btn-ceremony-paral').prop('disabled', true);
        
    }
    
    function GenerateParalCeremony()
    {
        
        var $ceremonytitle = $('#get-ceremony-paral option:selected').text();
        var $getceremony = $('#get-ceremony-paral').children(':selected').attr('value');
        var $roz         = $('#roz-paral').children(':selected').attr('value');  
        var $mah         = $('#mah-paral').children(':selected').attr('value');
        var $gah         = $('#gah-paral').children(':selected').attr('value');
        var $dedicatory  = $('#dedicatory-paral').children(':selected').attr('value');
        var $paral       = 1;
        

        if ( $getceremony == -1 ) {
            custom_alert("Please select a ceremony");
            return;
        }
        
         if ( $roz == 0 )   {
            custom_alert("Please select a day");
            return;
        }   
        
        if ( $mah == 0 )   {
            if ( ! ["31", "32", "33", "34", "35"].includes($roz) )  {
                custom_alert("Please select a month");
                return;
            }
        }        

        if ( $dedicatory == 0 )   {
            custom_alert("Please select a dedicatory");
            return;
        }
        
        if ( $gah == -1 )   {
            custom_alert("Please select a Gah");
            return;
        }     


        var $gahanbar_error = "The selected date is not a Gāhānbār" + "<br/>" +
                            "The following are the six Gāhānbār feasts:" + 
                            "<br/>" + "<br/>" +
                            "Maidyozarem: 11th to the 15th of the second month" + "<br/>" +
                            "Maidyoshahem: 11th to the 15th of the fourth month"+ "<br/>" +
                            "Paitishahem: 26th to the 30th of the sixth month"  + "<br/>" +
                            "Ayathrem: 26th to the 30th of the seventh month"   + "<br/>" +
                            "Maidyarem: 16th to the 20th of the tenth month"    + "<br/>" +
                            "Hamaspathmaidyem: 26th to the 30th of the twelfth month" + "<br/>" +
                            "plus the 5 Gatha days";

        var $only_gahanbar = "Only a dedicatory to Gāhānbār is possible on this date";    
        var $only_frawardigan = "A dedicatory to the Fravashis is only possible on the last five days of the year and on Frawardīgān";

        if ( ["0","3"].includes( $getceremony ) )   {
            if ( $dedicatory != 42 )  {
                if ( ["2", "4"].includes( $mah) ) {
                    if ( ["11","12","13","14","15"].includes($roz) ) {       
                        custom_alert($only_gahanbar);
                        return;  
                    }
                    
                } else if ( ["6", "7"].includes($mah) ) {
                    if ( ["26","27","28","29","30"].includes($roz) ) {    
                        custom_alert($only_gahanbar);
                        return;  
                    }
                
                } else if ( ["10"].includes($mah) ) {
                    if ( ["16","17","18","19","20"].includes($roz) ) {    
                        custom_alert($only_gahanbar);
                        return;  
                    }
                    
                } else if ( ["12"].includes($mah) ) {
                    if ( ["26","27","28","29","30"].includes($roz) ) {
                        if ( $dedicatory != 21 ) {
                            custom_alert($only_gahanbar);
                            return;
                        }
                    }
                }            
                
            }
            
        }

        if ( $dedicatory == 21 ) {
            if ( ["12"].includes($mah) ) {
                if ( ! ["26","27","28","29","30"].includes($roz) ) {     
                    custom_alert($only_frawardigan);
                    return;
                }
            
            } else if ( ["0"].includes($mah) ) {
            
                if ( ! ["31", "32", "33", "34", "35"].includes($roz) ) {    
                    custom_alert($only_frawardigan);
                    return;
                }
                
            } else if ( ["1"].includes($mah) )  {

                if ( ! ["1"].includes($roz) ) {    
                    custom_alert($only_frawardigan);
                    return;
                }                 

            } else {
                custom_alert($only_frawardigan);
                return;
            }
            
        }
         

        if ( $dedicatory == 42) {
            if ( ["2", "4"].includes( $mah) ) {
                if ( ! ["11","12","13","14","15"].includes($roz) ) {       
                    custom_alert($gahanbar_error);
                    return;  
                }
                    
            } else if ( ["6", "7"].includes($mah) ) {
                if ( ! ["26","27","28","29","30"].includes($roz) ) {    
                    custom_alert($gahanbar_error);
                    return;  
                }
                
            } else if ( ["10"].includes($mah) ) {
                if ( ! ["16","17","18","19","20"].includes($roz) ) {    
                    custom_alert($gahanbar_error);
                    return;  
                }
                    
            } else if ( ["12"].includes($mah) ) {
                if ( ! ["26","27","28","29","30"].includes($roz) ) {     
                    custom_alert($gahanbar_error);
                    return;
                }
            
            } else if ( ["0"].includes($mah) ) {
            
                if ( ! ["31", "32", "33", "34", "35"].includes($roz) ) {    
                    custom_alert($gahanbar_error);
                    return;
                }
                
            } else {
                custom_alert($gahanbar_error);
                return;               
            }
                
        }
    
        PreGenerateparal();
            
        var $ceremonies = ["Dron Yasht", "Yasna Rapithwin", "Yasna", "Visperad", "Videvdad", "Vishtasp Yasht", "", "", "", "Homast Paragna", "Paragna", "Visperad Do-Homast" ]; 
        var $gahs       = ["Hawan", "Rapithwin", "Uzerin", "Aiwisruthrem", "Ushahin"];
        
        
        $('#paral-viewer').html('<p style="padding-left:30px">' + $ceremonies[$getceremony] + ", " + $gahs[$gah] + " Gah is being generated... Please wait "
                                        + '<i class="fa fa-circle-o-notch fa-spin"/>' + '</p>'
                                 );
        
        var $link = "";
        $link = $link.concat("https://cab.geschkult.fu-berlin.de/exist/apps/cab/modules/ceremony_generator.xql?ceremony=", $getceremony , "&amp;paral=" , $paral , "&amp;gah=", $gah, "&amp;mah=", $mah, "&amp;roz=", $roz, "&amp;dedicatory=", $dedicatory );
        
        $link = $link.replace('amp;','');
        $link = $link.replace('amp;','');
        $link = $link.replace('amp;','');
        $link = $link.replace('amp;','');
        $link = $link.replace('amp;',''); // to replace this hack at one point

        // close all open popovers
        $('#paral-viewer').find('div.popover').remove();
    
        $.ajax({
                    
            url: $link,
            async: true,
            
            success: function( data ) {
                 $('#right-nav').css('visibility', 'visible');
                 $('.btn-ceremony-paral').prop('disabled', false);
                 $('#see_paral').css('display', 'block');
            
                 var $val_data = xmlToString(data);
                 $val_data = $val_data.replace( /GetStanzaInfo/g, "GetParalStanzaInfo" );           // update buttons
                 $('#paral-viewer').html( $val_data );

                 //$('#complex-selector-paral').collapse(); 
                 $('#main_button-paral').css('display','block');
                 
                 CreateParalNavbar( $ceremonytitle, $getceremony );
                 $('#paral-viewer').find('.tabcontent').first().css('display', 'block');
                 $('#paral-viewer').find('.stanza_width').css("max-width", "80%");
                 
                 var $sync = $('#sync_paral').attr('val');
                 if ( $sync == 1 )   {
                   GetParal();  
                 }                 
                 
            },
            
            type: "GET",
            processData: false,  // tell jQuery not to process the data
            contentType: false   // tell jQuery not to set contentType
                       
        }).done(function( data ) {
                console.log( data );
        });                         

        GetDescription( $getceremony, 1 );

        $('[data-toggle="popover"]').popover({container: 'body', html: true});
        
    };    

