    $( document ).ready(function(){    
        $('body').keydown(function(e) {
           
            var $selection = $('input[type=radio][name=ceremonyview]:checked').val();
            
            if ( $selection == 'simple') {
                if(e.keyCode == 37) { // left
                    PrevStanza();
                } else if(e.keyCode == 39) { // right
                    NextStanza();
                }
            }
        });     
    });
 
    function CreateKhordehNavbar( $ceremony, $long )
    {
        $('#nav_ceremony_title').text( $long ); // set title
        var $current = -1;
        var $ceremony_trim = $ceremony.replace(/\s/g, '');

        $('#ceremony_nav_menu').append('<ul id="list' + $ceremony_trim + '">');
        
        $.each($('#display-viewer').find('.tabcontent'), function() {
        
            $current++;
            var $id = this.id;
            
            var $corresp = $(this).find('h5').text();  
            $('#list' + $ceremony_trim ).append('<li>' 
                                            + '<a href="#' + $id + '" onclick="Nav(\'' + $id + '\')">' + '<span class="glyphicon glyphicon-play"/>'
                                            + $id + ' ' + $corresp + '</a>'
                                            + '</li>');
            
        });
        
        $('#ceremony_nav_menu').append('</ul>');
              
    }
 
    function CreateNavbar( $ceremony, $n )
    {
        $('#nav_ceremony_title').text( $ceremony ); // set title
        var $current = -1;
        var $main_current = 0;
        var $secondary_current = 1;
        
        var $ceremony_main = $ceremony;
        var $ceremony_alt  = $ceremony;

        if ( $n == 4 )    {
            $ceremony_alt = 'Videvdad Fragard';
        } else if ( $n == 5 )    {
            $ceremony_alt = 'Vishtasp Yasht Fragard';
        } else if ( $n == 11 )  {
            $ceremony_alt = "Do-Homast Fragard"
        }
        
        if ( $n == 0 )  {
            $current = 0;
        }
    
        var $list_alt = '';
        
        $.each($('#display-viewer').find('.tabcontent'), function() {
            
            var $id = this.id;
            var $corresp = $(this).find('h5').text();
           
            var $aux = 1;                
                            
                            
            if ( parseInt( $id.charAt( $id.indexOf( $current + '.') - 1 ) ) ) {
                $aux = 0;
                
            }
            
            if  ( ( isLessThan( 0, $id.indexOf( $current + '.') ) * $aux ) || ( $id == "SupplĀbZ1" ) || ( $id == "SupplĀbZ2" ) ) {
                    
                $('#li' + $list_alt + $current ).append('<li>' 
                  + '<a href="#' + $id + '" onclick="Nav(\'' + $id + '\')">' + '<span class="glyphicon glyphicon-play"/>'
                  + ' ' + $id + ' ' + $corresp 
                  + '</a>' + '</li>');
                  
            } else {
                $current++;
                $aux = 1;                
                            
                if ( parseInt( $id.charAt( $id.indexOf( $current + '.') - 1 ) ) ) {
                    $aux = 0;
                    
                }
    
                  // Fragards in Videvdad and Vishtasp and Visperad Do-Homast
                  if ( !isLessThan(0, $id.indexOf( $current + '.') ) || !$aux )    {
                    
                    if ( $ceremony == $ceremony_main ) {
                        
                        $main_current = $current;
                        $current = $secondary_current;
                        $ceremony = $ceremony_alt;
                        $list_alt = 'alt';
                        
                      } else {
                        $secondary_current = $current;
                        $current = $main_current;  
                      
                        $ceremony = $ceremony_main;
                        $list_alt = '';

                      }

                  }
            
                  $('#ceremony_nav_menu').append('<a href="#/" data-toggle="collapse" data-target="#list' + $list_alt + $current + '">' 
                                           + '<h4 id="nav_ceremony_header">' 
                                           + '<span class="glyphicon glyphicon-chevron-down"/> '
                                           + $ceremony + " " + $current 
                                           + '</h4>' + '</a>');
                  $('#ceremony_nav_menu').append('<div id="list' + $list_alt + $current + '" class="collapse" aria-expanded="true">' 
                                            + '<ul id="li' + $list_alt + $current + '"/>' 
                                            + '</div>' );
                  $('#li' + $list_alt + $current ).append('<li>' 
                                            + '<a href="#' + $id + '" onclick="Nav(\'' + $id + '\')">' + '<span class="glyphicon glyphicon-play"/>'
                                            + ' ' + $id + ' ' + $corresp + '</a>'
                                            + '</li>');
        
            }
               
        });    
        
    };
    
    function CreateParalNavbar( $ceremony, $n )        
    {
        $('#nav_ceremony_paral_title').text( $ceremony ); // set title
        
        var $current = -1;
            
        if ( $n == 0 )  {
            $current = 0;
        }
    
    
        $.each($('#paral-viewer').find('.tabcontent'), function() {
            
            var $id = this.id;
            var $corresp = $(this).find('h5').text();
             
             
            if ( ( isLessThan(0, $id.indexOf( $current + '.') ) ) || ( $id == "SupplĀbZ1" ) || ( $id == "SupplĀbZ2" ) ) {
                $('#li_paral' + $current ).append('<li>' 
                  + '<a href="#' + $id + '" onclick="NavParal(\'' + $id + '\')">' + '<span class="glyphicon glyphicon-play"/>'
                  + ' ' + $id + ' ' + $corresp 
                  + '</a>' + '</li>');
                
            } else {
                  $current++;
                  
                  $('#ceremony_paral_nav_menu').append('<a href="#/" data-toggle="collapse" data-target="#list_paral' + $current + '">' 
                                           + '<h4 id="nav_ceremony_header">' 
                                           + '<span class="glyphicon glyphicon-chevron-down"/> '
                                           + $ceremony + " " + $current 
                                           + '</h4>' + '</a>');
                  $('#ceremony_paral_nav_menu').append('<div id="list_paral' + $current + '" class="collapse" aria-expanded="true">' 
                                            + '<ul id="li_paral' + $current + '"/>' 
                                            + '</div>' );
                  $('#li_paral' + $current ).append('<li>' 
                                            + '<a href="#' + $id + '" onclick="NavParal(\'' + $id + '\')">' + '<span class="glyphicon glyphicon-play"/>'
                                            + ' ' + $id + ' ' + $corresp + '</a>'
                                            + '</li>');
        
            }
               
        });    
        
    };
  
    function PrevStanza()
    {
        $('div.popover').remove();
        Deselect();
        
        $('#display-viewer').find('.tabcontent').filter(function () { 
            return $(this).css('display') == 'block'
        }).prev().css('display', 'block');
        
        $('#display-viewer').find('.tabcontent').filter(function () { 
            return $(this).css('display') == 'block'
        }).next().css('display', 'none');
       
        var $sync = $('#sync_paral').attr('val');

        if ( $sync == 1 )   {
           GetParal();  
        }
        
    };
    
    function PrevParalStanza()
    {
        $('div.popover').remove();
        Deselect();
        
        $('#paral-viewer').find('.tabcontent').filter(function () { 
            return $(this).css('display') == 'block'
        }).prev().css('display', 'block');
        
        $('#paral-viewer').find('.tabcontent').filter(function () { 
            return $(this).css('display') == 'block'
        }).next().css('display', 'none');
        
    };    

    function NextStanza()
    {
        $('div.popover').remove();
        Deselect();
        
        $('#display-viewer').find('.tabcontent').filter(function () { 
            return $(this).css('display') == 'block'
        }).next().css('display', 'block');
        
        $('#display-viewer').find('.tabcontent').filter(function () { 
            return $(this).css('display') == 'block'
        }).prev().css('display', 'none');
       
        var $sync = $('#sync_paral').attr('val');

        if ( $sync == 1 )   {
           GetParal();  
        }
       
    };
    
    function NextParalStanza()
    {
        $('div.popover').remove();
        Deselect();
        
        $('#paral-viewer').find('.tabcontent').filter(function () { 
            return $(this).css('display') == 'block'
        }).next().css('display', 'block');
        
        $('#paral-viewer').find('.tabcontent').filter(function () { 
            return $(this).css('display') == 'block'
        }).prev().css('display', 'none');
       
    };   
   
    function Nav( $dest )
    {
        var $selection = $('input[type=radio][name=ceremonyview]:checked').val();

        if ( $selection == 'simple') {
            $('div.popover').remove();
        
            $('.tabcontent').css('display','none');

            $('#display-viewer').find('.tabcontent').filter(function () { 
                return $dest == this.id
            }).css('display', 'block');
        } else if ( $selection == 'compare' ) {
            $('div.popover').remove();

            if ( ! $('#ceremoniesextended:checked').is(':checked') ) {
        
               $('#display-viewer').find('.tabcontent').css('display','none');
      
            }
        
            $('#display-viewer').find('.tabcontent').filter(function () { 
                return $dest == this.id
            }).css('display', 'block');
        }
        
        var $sync = $('#sync_paral').attr('val');

        $('#current-select').css('display','none');

        if ( $sync == 1 )   {
           GetParal();  
        }        
        
    };
    
    function NavParal( $dest )
    {
        // in case paral navigation is on, hide this
        $('#no-paral').css('display','none');
        
        var $selection = $('input[type=radio][name=ceremonyview]:checked').val();
        
        if ( $selection == 'compare' ) {
            $('div.popover').remove();

            if ( ! $('#ceremoniesextended:checked').is(':checked') ) {
        
               $('#paral-viewer').find('.tabcontent').css('display','none');
      
            }
            
            $('#paral-viewer').find('.tabcontent').filter(function () { 
                return $dest == this.id
            }).css('display', 'block');
        }
        
        $('#current-select').css('display','none');
    };    
    
    function OpenNav() {
        $('#ceremony_nav').collapse('show');
        
        var $selection = $('input[type=radio][name=ceremonyview]:checked').val();
        
        if ( $selection == 'compare' )  {
            $('#ceremony_nav').css('width','480px');    
        } else {
            $('#ceremony_nav').css('width','300px');
            $('.option_button').css('margin-right','205px');
        }
        
    };
    
    function OpenManual() {
        $('#ceremony_manual').collapse('show');
        
        //var $selection = $('input[type=radio][name=ceremonyview]:checked').val();
        
        //if ( $selection == 'compare' )  {
            $('#ceremony_manual').css('width','840px');    
        //} else {
        //    $('#ceremony_nav').css('width','300px');
        //    $('.option_button').css('margin-right','205px');
        //}
        
    };    
    
    function CloseManual() {
        $('#ceremony_manual').css('width','0px');
        //$('.option_button').css('margin-right','0px');
    };    
    
    function OpenParalNav() {
        $('#ceremony_paral_nav').collapse('show');
        $('#ceremony_paral_nav').css('width','250px');
    };    
     
    function CloseNav() {
        $('#ceremony_nav').css('width','0px');
        $('.option_button').css('margin-right','0px');
    };
    
    function CloseParalNav() {
        $('#ceremony_paral_nav').css('width','0px');
    };
    
    function SetTitles( $settitle )
    {
        $('#ceremony_title').text( $settitle ); // set title
        jQuery('#ceremonyextended').attr('checked', true);
        $('#ceremony_options').css('display','block');
        $('#ceremony_navigator').css('display','none');  
        $('#ceremony_search').css('display','none');
    };
