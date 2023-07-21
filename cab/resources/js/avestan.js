    function isLessThan(a, b) {
        return Object.is((a-b)%1, -0);
    }  
    
    function ConvertChr( text, direction ) 
    {
        Deselect();
        
        var $latin_char   = ["a", "ā", "å", "ā̊", "ą", "ą̇", "ə", "ə̄", "e", "ē", "o", "ō", "i", "ī", "u", "ū", "k", "x", "x́", "xᵛ", "g", "ġ", "γ", "c", "j", "t", "ϑ", "d", "δ", "t̰", "p", "f", "b", "β", "ŋ", "ŋ́", "ŋᵛ", "n", "ń", "ṇ", "m", "m̨","y", "ẏ", "v", "r", "s", "z", "š", "ž", "š́", "ṣ̌", "h" ];
        
        var $avestan_char = ["𐬀", "𐬁", "𐬂", "𐬃", "𐬄", "𐬅", "𐬆", "𐬇", "𐬈", "𐬉", "𐬊", "𐬋", "𐬌", "𐬍", "𐬎", "𐬏", "𐬐", "𐬑", "𐬒", "𐬓", "𐬔", "𐬕", " 𐬖", "𐬗", "𐬘", "𐬙", "𐬚", "𐬛", "𐬜", "𐬝", "𐬞", "𐬟", "𐬠", "𐬡", "𐬢", "𐬣", "𐬤", "𐬥", "𐬦", " 𐬧", "𐬨", "𐬩", "𐬪",  "𐬫", "𐬬", "𐬭", "𐬯", "𐬰", "𐬱", "𐬲", "𐬳", "𐬴", "𐬵"];

        for (i = 0; isLessThan( i, $latin_char.length ); i++) {
            
            
            if (direction == -1) {
                // ligatures
                text = text.split( "ah" ).join( "ڕ" );
                text = text.split( "št" ).join( "ڒ");
                text = text.split( "ša" ).join( "ړ");
                
                // problematic ones
                text = text.split( "ṇ" ).join( "‫ٹ‬");
                text = text.split( "ɱ" ).join( "𐬩");
                text = text.split( "ā̊" ).join( "𐬃" );
                text = text.split( "å" ).join( "𐬂" );
                text = text.split( "xᵛ" ).join( "𐬓" );
                text = text.split( "ŋᵛ" ).join( "𐬤" );
                text = text.split( "t̰" ).join( "𐬝" );
                text = text.split( "ṣ̌" ).join( "𐬴" );
                text = text.split( "š́" ).join( "𐬳" );
                text = text.split( "ń" ).join( "𐬦" );
                text = text.split( "ə̄" ).join("𐬇");
                
                text = text.split( "θ" ).join( "𐬚" );
                
                text = text.split( $latin_char[i] ).join( $avestan_char[i] );
                
                    //WIP
            } else if ( direction == 1 )  {
                // dismantle ligatures
                text = text.split( "ڕ" ).join( "ah" );
                text = text.split( "ڒ" ).join( "št" );
                text = text.split( "ړ" ).join( "ša" );
                
                text = text.split( "‫ٹ‬" ).join( "ṇ" );
                
                text = text.split( $avestan_char[i] ).join( $latin_char[i] );    
            
                // zot and raspig
                //text = text.split('zōt ud rāspīg').join('zōt ud rāspīg');
                }
        } 
        
  
        text = text.split('𐬰𐬋𐬙 𐬎𐬛 𐬭𐬁𐬯𐬞𐬍𐬔').join('');
        text = text.split('𐬭𐬁𐬯𐬞𐬍𐬔').join('');
        text = text.split('𐬰𐬋𐬙').join('');
        
        return text;
    }
    
    function CloseFunctionAvestan()
    {
        $('#avestan-modal').html('<p>' + 'Retrieving word information ' + '<i class="fa fa-circle-o-notch fa-spin"/>' +
        '</p>');
    }    
    
    function AvestanChar()
    {
        $('#modalavestan').dialog(
            { width: 870, close: CloseFunctionAvestan}); 
        
        $stanza_full = $('#stanza_full').clone( true );
        
        $( $stanza_full ).find('wordlist').find('ab').css('direction', 'rtl');
        $( $stanza_full ).find('wordlist').find('ab').css('unicode-bidi', 'bidi-override');
            
        $( $stanza_full ).find('wordlist').find('ab').addClass("avestantext");
        $( $stanza_full ).css('text-align','right');
        
        
        // remove notes, especially in frauuaranes
        $.each($($stanza_full).find('.note'), function() {
              var $wordlist = $( this ).html();
              $( this ).replaceWith( '' );  
        });
        
        $.each($($stanza_full).find('note'), function() {
              var $wordlist = $( this ).html();
              $( this ).replaceWith( '' );  
        });
        
        $.each($($stanza_full).find('l'), function() {
                $ab_this = $( this );
                $ab_text = $( this ).text();
    
                $ab_text = ConvertChr( $ab_text, -1 );
                $( this ).text( $ab_text );
        });
        
        $.each($($stanza_full).find('wordlist').find('ab'), function() {
        
            if ( $(this).find('l').length == 0 ) {
                $ab_this = $( this );
                $ab_text = $( this ).text();
    
                $ab_text = ConvertChr( $ab_text, -1 );
                $( this ).text( $ab_text );
            }
        });
        
        $.each($($stanza_full).find('wordlist'), function() {
        
            if ( $(this).find('ab').length == 0 ) {
                $ab_this = $( this );
                $ab_text = $( this ).text();
    
                $ab_text = ConvertChr( $ab_text, -1 );
                $( this ).text( $ab_text );    
            }
        });        
        
        $.each($($stanza_full).find('wordlist'), function() {
            $( this ).replaceWith( '<wordlist_ab>' + $( this ).html() + '</wordlist_ab' );
        });
     
        $.each($($stanza_full).find('xmlid'), function() {
              var $wordlist = $( this ).html().replace( " :", "" );
              $( this ).replaceWith( '<xmlid_ab>' + $wordlist + '</xmlid_ab' );
        });
        
        // remove special floating parts (like ratus)
        $.each($($stanza_full).find('xml_id'), function() {
              var $wordlist = $( this ).html();
              $( this ).replaceWith( '' );  
        });
        
        $.each($($stanza_full).find('.frauuarane'), function() {
              var $wordlist = $( this ).html();
              $( this ).replaceWith( '<xmlid_ab>' + $wordlist + '</xmlid_ab' );  
        });

        $( '#modalavestan' ).html( $stanza_full );
      
    }
    