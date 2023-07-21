    $( document ).ready(function(){
        $fulltext = $( "#word_text" ).html();
        $fulltext = $fulltext.replace( /--/g,'<br/>--');       
        $fulltext = $fulltext.replace( /. #/g,'<br/><br/>#');
        $( "#word_text" ).html( $fulltext );
    });