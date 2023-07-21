    function CloseModal( $id )
    {
        if ( $id == 1  )    {
            $('#modalstanza').css('display','none');
        } else if ( $id == 2 )  {
            $('#modalstanza-paral').css('display','none');
        }
    }
        
        
    function ShowMetadata()
    {
        $('#modalstanza').css('display','block');
        
        var $paral = document.getElementById('ceremonyparal');
        if ($paral.checked )    {
            $('#modalstanza-paral').css('display','block');
        }

    }