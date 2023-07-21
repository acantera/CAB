    $( document ).ready(function(){
        $('input[type=checkbox][name=ceremoniesextended]').change( function() {
    
            if ( $('#ceremoniesextended:checked').is(':checked') ) {
                
                $('#ceremony_navigator').css('display','none');
                $('#comparative_ceremony_navigator').css('display','none');
                Deselect();
                $("[data-toggle='popover']").popover('hide');
                $('.tabcontent').css('display','block'); 
                $('.tabcontent').css('min-height','0px');
                
                $('#back_to_top').css('display','block');
                
                // scroller on
                var $paralHeight = $( '#display-viewer' ).height(); 
                document.getElementById("main-paral-viewer").style.height = $paralHeight.toString() + "px";
                document.getElementById("paral-viewer").style.height = $paralHeight.toString() + "px"; 
                $( '#main-paral-viewer' ).addClass( "viewer-right-alt" );
                $( '#paral-viewer' ).append( '<div id="aux-scroller" style="height:' + $paralHeight + 'px"></div>' );
                $( '.viewer-right' ).css('width','100%');                 
                
            } else {
                
                $('#comparative_ceremony_navigator').css('display','block');
                Deselect();
                $("[data-toggle='popover']").popover('hide');
                $('.tabcontent').css('display','none'); 
                $('.tabcontent').css('min-height','400px');
                $('.stanza_width').css("max-width", "50%");
                $('#display-viewer').find('.tabcontent').first().css('display', 'block');      // load first element
                $('#paral-viewer').find('.tabcontent').first().css('display', 'block');      // load first element
                
                
                
                $('#back_to_top').css('display','none');
                
                // scroller off
                $( '#main-paral-viewer' ).removeClass( "viewer-right-alt" );
                $( '#aux-scroller' ).remove();
                $( '.viewer-right' ).css('width','50%');  
                document.getElementById("main-paral-viewer").style.height = "auto";
                document.getElementById("paral-viewer").style.height = "auto";

            }
        });
        
        $('input[type=checkbox][name=shownerangs]').change( function() {
            if ( $('#shownerangs:checked').is(':checked') ) {
                $("ab1").css("display", "none");
            } else {
            
                $("ab1").css("display", "block");
            }
            
            
        });
        
        $('input[type=radio][name=ceremonyview]').change(function() {
            // keep main selector bar active
            $('#selector-main').prop('disabled', false );
            
            // rest of options
            $('#ceremoniesextended').prop( "checked", false );
            CloseModal( 1 );
            CloseModal( 2 );
            
            $('#modalword').dialog('close');
            $('#modalnerang').dialog('close');
            $('#modalvideo').dialog('close');
            
            if (this.value == 'search') {
                $('#ceremony_navigator').css('display','none');
                
                $('#comparative_ceremony_navigator').css('display','none');
                Deselect();
                $("[data-toggle='popover']").popover('hide');
                $('#cerem_search').val('');
                $('#ceremony_search').css('display','block');
                $('.tabcontent').css('display','none');
                $('.tabcontent').css('min-height','0px');
                $('.butpopall').css('display','none');
                
                $('#searchlist').attr('checked', true );
                $('#searchavestan').attr('checked', true );
                $('#searchtranslation').attr('checked', false );
                $('#searchnotes').attr('checked', false );
    
                $('#paral_button').css("display", "none");
                $('#complex-selector-paral').css("display","none");
    
                $('#display-viewer').removeClass("viewer-left");
                $('#paral-viewer').removeClass("viewer-right");
                
                $('#modalstanza').removeClass("viewer-left");
                $('#modalstanza-paral').removeClass("viewer-right");
                
                $('#paral-viewer').css("display","none");
                $('#ceremony_nav').collapse('hide');
                $('#ceremony_paral_nav').collapse('hide');
                $('#ceremony_paral_nav').css("display","none");
                $('#see_paral').css('display','none');
    
                $('#ceremony-paral').css('display','none');
    
                $('.stanza_width').css("max-width", "50%");
    
                var $direction = $('#avestan_char').attr('val');
                
                if ( $direction == -1 )  {       
                     AvestanChar(); 
                }
                
                $('#avestan_char').css('visibility','hidden');
                $('#sync_paral').css('visibility','hidden');
                
                $('#back_to_top').css('display','none');
                
                $('.col_selector').removeClass('col-lg-6').addClass('col-lg-12');
                $('.col_option').removeClass('col-lg-12').addClass('col-lg-4');
                $('.col_navbar').removeClass('col-lg-12').addClass('col-lg-3');
                
                $('.btn-ceremony').prop('disabled', false );
                
                document.getElementById("main-paral-viewer").style.height = "auto";
                
            } else if (this.value == 'simple') {
                Deselect();
                $('#cerem_search').val('');
                $("[data-toggle='popover']").popover('hide');
                $('#ceremony_search').css('display','none');
                $('.tabcontent').css('display','none');
                $('#ceremony_navigator').css('display','block');
                $('#comparative_ceremony_navigator').css('display','none');
                $('.tabcontent').first().css('display', 'block');      // load first element
                $('.tabcontent').css('min-height','400px');
                $('.butpopall').css('display','none');
    
                $('#paral_button').css("display", "none");
                $('#complex-selector-paral').css("display","none");
    
                $('#display-viewer').removeClass("viewer-left");
                $('#paral-viewer').removeClass("viewer-right");
                
                $('#modalstanza').removeClass("viewer-left");
                $('#modalstanza-paral').removeClass("viewer-right");
                
                $('#paral-viewer').css("display","none");
                $('#ceremony_nav').collapse('hide');
                $('#ceremony_paral_nav').collapse('hide');
                $('#ceremony_paral_nav').css("display","none");
                $('#see_paral').css('display','none');
                
                $('#ceremony-paral').css('display','none');
                
                $('.stanza_width').css("max-width", "50%");
                
                $('#avestan_char').css('visibility','visible');
                $('#sync_paral').css('visibility','hidden');
                
                $('#back_to_top').css('display','none');
    
                $('.col_selector').removeClass('col-lg-6').addClass('col-lg-12');
                $('.col_option').removeClass('col-lg-12').addClass('col-lg-4');
                $('.col_navbar').removeClass('col-lg-12').addClass('col-lg-3');
                
                $('.btn-ceremony').prop('disabled', false);
                
                document.getElementById("main-paral-viewer").style.height = "auto";

                
            } else if ( this.value == 'extended' )  {
                
                $('#paral-viewer').css("display","none");
                $('#ceremony_paral_nav').css("display","none");
                $('#see_paral').css('display','none');
                
                $('#paral_button').css("display", "none");
                $('#complex-selector-paral').css("display","none");
                
                $('#ceremony_nav').collapse('hide');
                $('#ceremony_paral_nav').collapse('hide');
                $('#ceremony_paral_nav').css("display","none");
                
                $('#ceremony-paral').css('display','none');
                
                $('#display-viewer').removeClass("viewer-left");
                $('#paral-viewer').removeClass("viewer-right");
                
                $('#modalstanza').removeClass("viewer-left");
                $('#modalstanza-paral').removeClass("viewer-right");
                
                $('#ceremony_navigator').css('display','none');
                $('#comparative_ceremony_navigator').css('display','none');
                Deselect();
                $("[data-toggle='popover']").popover('hide');
                $('#ceremony_search').css('display','none');
                
                $('.tabcontent').css('display','block'); 
                $('.tabcontent').css('min-height','0px');
                $('.butpopall').css('display','block');
                
                $('#back_to_top').css('display','block');
    
                $('.col_selector').removeClass('col-lg-6').addClass('col-lg-12');
                $('.col_option').removeClass('col-lg-12').addClass('col-lg-4');
                $('.col_navbar').removeClass('col-lg-12').addClass('col-lg-3');
               
                $('.btn-ceremony').prop('disabled', false);
               
               document.getElementById("main-paral-viewer").style.height = "auto";
               
            } else if (this.value == 'compare') {
                
                Deselect();
                $('#paral-viewer').css("display","block");
                $('#mega-selector').collapse('show');
                $('#paral_button').css("display", "block");
                $('#complex-selector-paral').css("display","block");
                
                $('#cerem_search').val('');
                $("[data-toggle='popover']").popover('hide');
                $('#ceremony_search').css('display','none');
                $('.tabcontent').css('display','none');
                $('#ceremony_navigator').css('display','none');
                $('#comparative_ceremony_navigator').css('display','block');
    
                $('#display-viewer').addClass("viewer-left");
                $('#paral-viewer').addClass("viewer-right");            
    
                $('#modalstanza').addClass("viewer-left");
                $('#modalstanza-paral').addClass("viewer-right");
    
                $('.butpopall').css('display','none');
                $('.tabcontent').css('display','none');
                $('#display-viewer').find('.tabcontent').first().css('display', 'block');      // load first element
                $('#paral-viewer').find('.tabcontent').first().css('display', 'block');      // load first element
                $('#ceremony_paral_nav').css("display","block");
                $('#see_paral').css('display','block');
                
                $('#ceremony-paral').css('display','block');
                $('#ceremony_nav').collapse('hide');
                
                $('.stanza_width').css("max-width", "80%");
                
                $('#avestan_char').css('visibility','visible');
                $('#sync_paral').css('visibility','visible');
                
                $('#back_to_top').css('display','none');
                
                // change viewer form
    
                $('.col_selector').removeClass('col-lg-12').addClass('col-lg-6');
                $('.col_option').removeClass('col-lg-4').addClass('col-lg-12');
                $('.col_navbar').removeClass('col-lg-3').addClass('col-lg-12');
    
                $('.btn-ceremony').prop('disabled', true);
                $('.btn-ceremony-paral').prop('disabled', false);
                
                // scroller off - in case full paral was previously turned on
                $( '#main-paral-viewer' ).removeClass( "viewer-right-alt" );
                $( '#aux-scroller' ).remove();
                $( '.viewer-right' ).css('width','50%');  
                document.getElementById("main-paral-viewer").style.height = "auto";
                document.getElementById("paral-viewer").style.height = "auto";
                
                $('#selector-main').prop('disabled', true );
                
            }
            
            $('#main-mega-selector').removeClass('col-lg-4').addClass('col-lg-12');

        }); 
        
    });
    
    function PreGenerateKhordehDetails()
    {
        $('#shownerangs').hide();
        $('#shownerangs_label').hide();
        $('#ceremonyparal').hide();
        $('#ceremonyparal_label').hide();
        
        $('#ceremony_nav_menu').html('');
    }

    function PreGenerateDetails()
    {
        // show possibly hidden elements from khordeh generator
        $('#shownerangs').show();
        $('#shownerangs_label').show();
        $('#ceremonyparal').show();
        $('#ceremonyparal_label').show();
        ////////////
        
        CloseModal( 1 );
        CloseModal( 2 );
        $('#ceremony_options').css('display','none');
        $('#ceremony_navigator').css('display','none');
        $('#comparative_ceremony_navigator').css('display','none');
        $('#ceremony_search').css('display','none');
        $('#cerem_search').val('');
        $('#ceremony_nav_menu').html('');
        $('#ceremony_paral_nav_menu').html('');
        $('#ceremony_nav').collapse('hide');
        $('#ceremony_paral_nav').collapse('hide');
        $('#ceremony_paral_nav').css('display','none');
        $('#see_paral').css('display','none');
        $('#ceremony-paral').css('display','none');
        $('#paral-viewer').css("display","none");
        $('.butpopall').css('display','none');
        $('.butpopall').attr('value', 0); 
        $('.btn-ceremony').prop('disabled', true);
        $('.btn-ceremony-paral').prop('disabled', true);
        $('#avestan_char').attr( 'val', 1 );
        $('#display-viewer').removeClass("viewer-left");
        $('#paral-viewer').removeClass("viewer-right");    
        $('#modalstanza').removeClass("viewer-left");
        $('#modalstanza-paral').removeClass("viewer-right");
        
        $('#main_button').css('display','none');
        $('#back_to_top').css('display','block');
    }
