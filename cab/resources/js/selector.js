    $( document ).ready(function(){
        $('#selector-main').on('change', function (e) { 
            var $valueSelected = this.value;
            if ( $valueSelected == -1 ) {
                PopulateCeremonies( 0 );
                PopulateKhordehCeremonies( 0 );
                
                $('#mega-selector-yasna').css('display','none');
                $('#mega-selector-khordeh').css('display','none');
                $('#mega-selector-khordeh-type').css('display','none');
                
                $('#version_alert').css('display','none');
            
            } else if ( $valueSelected == 0 )  {
                PopulateCeremonies( 1 );
                PopulateKhordehCeremonies( 0 );
                
                $('#mega-selector-yasna').css('display','block');
                $('#mega-selector-khordeh').css('display','none');
                $('#mega-selector-khordeh-type').css('display','none');

                $('#version_alert').css('display','none');

            } else if ( $valueSelected == 1 )   {
                PopulateCeremonies( 2 );
                PopulateKhordehCeremonies( 0 );
                
                $('#mega-selector-yasna').css('display','block');
                $('#mega-selector-khordeh').css('display','none');
                $('#mega-selector-khordeh-type').css('display','none');
    
                $('#version_alert').css('display','none');
    
            } else if ( $valueSelected == 2 )   {
                PopulateCeremonies( 0 );
                PopulateKhordehCeremonies( 0 );
                
                $('#mega-selector-yasna').css('display','none');
                $('#mega-selector-khordeh-type').css('display','block');
                $('#mega-selector-khordeh').css('display','none');
            
                $('#version_alert').css('display','block');
                
            } else if ( $valueSelected == 3 )   {
                PopulateCeremonies( 3 );
                PopulateKhordehCeremonies( 0 );
                
                $('#mega-selector-yasna').css('display','block');
                $('#mega-selector-khordeh-type').css('display','none');
                $('#mega-selector-khordeh').css('display','none');
                
                $('#version_alert').css('display','none');
            }

        });
       
        $('#selector-main-khordeh').on('change', function (e) { 
            
            $('#gah-khordeh').prop('disabled', false )
            $('#dedicatory-khordeh').prop('disabled', false )
            
            var $valueSelected = this.value;
            
            if ( $valueSelected == -1 ) {
                
                $('#mega-selector-khordeh').css('display','none');
            
            } else if ( $valueSelected == 0 )  {
             
                PopulateKhordehCeremonies( 1 );
                $('#mega-selector-khordeh').css('display','block');

            } else if ( $valueSelected == 1 )   {
                
                PopulateKhordehCeremonies( 2 );
                $('#mega-selector-khordeh').css('display','block');

            }
        });    
        
        $('#get-ceremony').on('change', function (e) {
            $('#mah').prop('disabled', false);
        
            var $optionSelected = $("option:selected", this);
            var $valueSelected  = this.value;
            
            EmptySelectors( 0 );
            
            PopulateDays( $valueSelected, 0 );
            PopulateMonths( $valueSelected, 0, 0 );
            
            if ( $valueSelected == 1 )  {
                var o = new Option("39. Rapiθβin", "39");
                $('#dedicatory').append(o);
        
            } else if ( $valueSelected == 4 ) {
                //var o = new Option("1. Ahura Mazdā", "1");
                //$('#dedicatory').append(o);
                //var o = new Option("19. Srōš", "19");
                //$('#dedicatory').append(o);
                //var o = new Option("21. Frawardēn", "21");
                //$('#dedicatory').append(o);
                PopulateDedicatoryVidevdad( 0 );
    
            } else {
                PopulateDedicatory( $valueSelected, 0 );
            }
            
            PopulateGah( $valueSelected, 0 );
            
            SelectSpecific( this.value, 0 );
    
        });
        
        $('#get-ceremony-khordeh').on('change', function (e) {
            var $optionSelected = $("option:selected", this);
            var $valueSelected  = this.value;
            
            EmptyKhordehSelectors( 0 );
            
            PopulateKhordehType( $valueSelected, 0 );
            PopulateKhordehGah( $valueSelected, 0 );
            
            SelectKhordehSpecific( $valueSelected, 1 );

        });
    
        $('#get-ceremony-paral').on('change', function (e) {
            $('#mah-paral').prop('disabled', false);
        
            var $optionSelected = $("option:selected", this);
            var $valueSelected  = this.value;
            
            EmptySelectors( 1 );
            
            PopulateDays( $valueSelected, 1 );
            PopulateMonths( $valueSelected, 1, 0 );
            
            if ( $valueSelected == 1 )  {
                var o = new Option("39. Rapiθβin", "39");
                $('#dedicatory-paral').append(o);
        
            } else if ( $valueSelected == 4 ) { // Videvdad
                //var o = new Option("1. Ahura Mazdā", "1");
                //$('#dedicatory-paral').append(o);
                //var o = new Option("19. Srōš", "19");
                //$('#dedicatory-paral').append(o);
                //var o = new Option("21. Frawardēn", "21");
                //$('#dedicatory-paral').append(o);
                PopulateDedicatoryVidevdad( 1 );
    
            } else {
                PopulateDedicatory( $valueSelected, 1  );
            }
            
            PopulateGah( $valueSelected, 1  );
            
            SelectSpecific( this.value, 1  );
    
        });    
        
        $('#roz').on('change', function (e) {
            var $roz = $('#roz').children(":selected").attr("value");
            
            if  ( isLessThan( 30, $roz ) ) {
                $('#mah').prop('disabled', true);
                $('#mah').val(0);
            } else {
                $('#mah').prop('disabled', false);
            }
            
        });       
        
        $('#roz-paral').on('change', function (e) {
            
            var $roz = $('#roz-paral').children(":selected").attr("value");
            
            if  ( isLessThan( 30, $roz ) ) {
                $('#mah-paral').prop('disabled', true);
                $('#mah-paral').val(0);
            } else {
                $('#mah-paral').prop('disabled', false);
            }
            
        });
        
        $('#dedicatory').on('change', function (e) {
            $('#mah').prop('disabled', false);
            var $optionSelected = $("option:selected", this);
            var $valueSelected  = this.value;
            
            if ( $valueSelected == 39 ) {
                $('#gah').children().remove().end().append('<option value="-1"/>');
                var o = new Option("Rapithwin", "1");
                $('#gah').append(o);
            
            } else {
                $('#gah').children().remove().end().append('<option value="-1"/>');        
                 
                var $cerval   = $("#get-ceremony").val();
                
                if ( $cerval != 4 ) {
                    if ( ![ "2", "5" ].includes( $cerval ) )  {
                        var o = new Option("Ushahin", "4");
                        $('#gah').append(o);
                    }                    
                    
                    var o = new Option("Hawan", "0");
                    $('#gah').append(o);
                
                    var o = new Option("Rapithwin", "1");
                    $('#gah').append(o);
                    
                    var o = new Option("Uzerin", "2");
                    $('#gah').append(o);
                    
                    if ( $cerval != 2 ) {
                        var o = new Option("Aiwisruthrem", "3");
                        $('#gah').append(o);
                    }
                    
                } else if ( $cerval != 2 ) {
                    var o = new Option("Ushahin", "4");
                    $('#gah').append(o);
                }
            }
            
            var $cerem = $("#get-ceremony").val();
            
            if ( $cerem == 5 )    {
                if ( ( $valueSelected == 26 ) || ( $valueSelected == 31 ) ) {
                    var o = new Option("Ushahin", "4");
                    $('#gah').append(o);        
                    
                }
            } 
            
            if ( $valueSelected == 44 ) {
                $('#roz').children().remove().end().append('<option value="0"/>');
                var o = new Option("1. Dadvah Ahura Mazdā", "1");
                $('#roz').append(o);  
                var o = new Option("8. Dadvah Ahura Mazdā", "8");
                $('#roz').append(o);  
                var o = new Option("15. Dadvah Ahura Mazdā", "15");
                $('#roz').append(o);  
                 var o = new Option("23. Dadvah Ahura Mazdā", "23");
                $('#roz').append(o);    
                    
            } else if ( $valueSelected == 45 ) {
                $('#roz').children().remove().end().append('<option value="0"/>');
                var o = new Option("2. Vohu Manah", "2");
                $('#roz').append(o);
                var o = new Option("12. Māh", "12");
                $('#roz').append(o);
                var o = new Option("14. Geuš Urvan", "14");
                $('#roz').append(o);
                var o = new Option("21. Rāman", "21");
                $('#roz').append(o);
                
            } else if ( $valueSelected == 46 ) {
                $('#roz').children().remove().end().append('<option value="0"/>');
                var o = new Option("3. Aša Vahišta", "3");
                $('#roz').append(o);
                var o = new Option("9. Ātar", "9");
                $('#roz').append(o);
                var o = new Option("17. Sraoša", "17");
                $('#roz').append(o);
                var o = new Option("20. Verethragna", "20");
                $('#roz').append(o);
                
            } else if ( $valueSelected == 47 ) {
                $('#roz').children().remove().end().append('<option value="0"/>');
                var o = new Option("4. Khšathra Vairya", "4");        
                $('#roz').append(o);
                var o = new Option("11. Hvar", "11");
                $('#roz').append(o);
                var o = new Option("16. Mithra", "16");
                $('#roz').append(o);
                var o = new Option("27. Asmān", "27");
                $('#roz').append(o);
                var o = new Option("30. Anaghra Raočā", "30");
                $('#roz').append(o);
                
            } else if ( $valueSelected == 48 ) {
                $('#roz').children().remove().end().append('<option value="0"/>');
                var o = new Option("5. Spenta Ārmaiti", "5");        
                $('#roz').append(o);
                var o = new Option("10. Āpō", "10");
                $('#roz').append(o);
                var o = new Option("24. Daēna", "24");
                $('#roz').append(o);
                var o = new Option("25. Aši", "25");
                $('#roz').append(o);
                var o = new Option("29. Manthra Spenta", "29");
                $('#roz').append(o);
                
            } else if ( $valueSelected == 49 ) {
                $('#roz').children().remove().end().append('<option value="0"/>');
                var o = new Option("6. Haurvatāt", "6"); 
                $('#roz').append(o);
                var o = new Option("13. Tištrya", "13");
                $('#roz').append(o);
                var o = new Option("19. Fravašayō", "19");
                $('#roz').append(o);
                var o = new Option("22. Vāta", "22");
                $('#roz').append(o);
                
            } else if ( $valueSelected == 50 ) {
                $('#roz').children().remove().end().append('<option value="0"/>');
                var o = new Option("7. Ameretāt", "7");
                $('#roz').append(o);
                var o = new Option("18. Rašnu", "18");
                $('#roz').append(o);
                var o = new Option("26. Arštāt", "26");
                $('#roz').append(o);
                var o = new Option("28. Zam", "28");
                $('#roz').append(o);
                
            } else {
                $('#roz').children().remove().end().append('<option value="0"/>');
                PopulateDays( $("#get-ceremony").val() );
            }
            
        });
        
        $('#dedicatory-paral').on('change', function (e) {
            $('#mah-paral').prop('disabled', false);
            var $optionSelected = $("option:selected", this);
            var $valueSelected  = this.value;
            
            if ( $valueSelected == 39 ) {
                $('#gah-paral').children().remove().end().append('<option value="-1"/>');
                var o = new Option("Rapithwin", "1");
                $('#gah-paral').append(o);
            
            } else {
                $('#gah-paral').children().remove().end().append('<option value="-1"/>');        
                 
                var $cerval   = $("#get-ceremony-paral").val();
                
                if ( $cerval != 4 ) {
                    if ( ![ "2", "5" ].includes( $cerval ) )  {
                        var o = new Option("Ushahin", "4");
                        $('#gah-paral').append(o);
                    }                    
                    
                    var o = new Option("Hawan", "0");
                    $('#gah-paral').append(o);
                
                    var o = new Option("Rapithwin", "1");
                    $('#gah-paral').append(o);
                    
                    var o = new Option("Uzerin", "2");
                    $('#gah-paral').append(o);
                    
                    if ( $cerval != 2 ) {
                        var o = new Option("Aiwisruthrem", "3");
                        $('#gah-paral').append(o);        
                    }
                    
                } else if ( $cerval !=2 ) {
                    var o = new Option("Ushahin", "4");
                    $('#gah-paral').append(o);
                }
            }
            
            var $cerem = $("#get-ceremony-paral").val();
            
            if ( $cerem == 5 )    {
                if ( ( $valueSelected == 26 ) || ( $valueSelected == 31 ) ) {
                    var o = new Option("Ushahin", "4");
                    $('#gah-paral').append(o);        
                    
                }
            } 
            
            if ( $valueSelected == 44 ) {
                $('#roz-paral').children().remove().end().append('<option value="0"/>');
                var o = new Option("1. Dadvah Ahura Mazdā", "1");
                $('#roz-paral').append(o);  
                var o = new Option("8. Dadvah Ahura Mazdā", "8");
                $('#roz-paral').append(o);  
                var o = new Option("15. Dadvah Ahura Mazdā", "15");
                $('#roz-paral').append(o);  
                 var o = new Option("23. Dadvah Ahura Mazdā", "23");
                $('#roz-paral').append(o);    
                    
            } else if ( $valueSelected == 45 ) {
                $('#roz-paral').children().remove().end().append('<option value="0"/>');
                var o = new Option("2. Vohu Manah", "2");
                $('#roz-paral').append(o);
                var o = new Option("12. Māh", "12");
                $('#roz-paral').append(o);
                var o = new Option("14. Geuš Urvan", "14");
                $('#roz-paral').append(o);
                var o = new Option("21. Rāman", "21");
                $('#roz-paral').append(o);
                
            } else if ( $valueSelected == 46 ) {
                $('#roz-paral').children().remove().end().append('<option value="0"/>');
                var o = new Option("3. Aša Vahišta", "3");
                $('#roz-paral').append(o);
                var o = new Option("9. Ātar", "9");
                $('#roz-paral').append(o);
                var o = new Option("17. Sraoša", "17");
                $('#roz-paral').append(o);
                var o = new Option("20. Verethragna", "20");
                $('#roz-paral').append(o);
                
            } else if ( $valueSelected == 47 ) {
                $('#roz-paral').children().remove().end().append('<option value="0"/>');
                var o = new Option("4. Khšathra Vairya", "4");        
                $('#roz-paral').append(o);
                var o = new Option("11. Hvar", "11");
                $('#roz-paral').append(o);
                var o = new Option("16. Mithra", "16");
                $('#roz-paral').append(o);
                var o = new Option("27. Asmān", "27");
                $('#roz-paral').append(o);
                var o = new Option("30. Anaghra Raočā", "30");
                $('#roz-paral').append(o);
                
            } else if ( $valueSelected == 48 ) {
                $('#roz-paral').children().remove().end().append('<option value="0"/>');
                var o = new Option("5. Spenta Ārmaiti", "5");        
                $('#roz-paral').append(o);
                var o = new Option("10. Āpō", "10");
                $('#roz-paral').append(o);
                var o = new Option("24. Daēna", "24");
                $('#roz-paral').append(o);
                var o = new Option("25. Aši", "25");
                $('#roz-paral').append(o);
                var o = new Option("29. Manthra Spenta", "29");
                $('#roz-paral').append(o);
                
            } else if ( $valueSelected == 49 ) {
                $('#roz-paral').children().remove().end().append('<option value="0"/>');
                var o = new Option("6. Haurvatāt", "6"); 
                $('#roz-paral').append(o);
                var o = new Option("13. Tištrya", "13");
                $('#roz-paral').append(o);
                var o = new Option("19. Fravašayō", "19");
                $('#roz-paral').append(o);
                var o = new Option("22. Vāta", "22");
                $('#roz-paral').append(o);
                
            } else if ( $valueSelected == 50 ) {
                $('#roz-paral').children().remove().end().append('<option value="0"/>');
                var o = new Option("7. Ameretāt", "7");
                $('#roz-paral').append(o);
                var o = new Option("18. Rašnu", "18");
                $('#roz-paral').append(o);
                var o = new Option("26. Arštāt", "26");
                $('#roz-paral').append(o);
                var o = new Option("28. Zam", "28");
                $('#roz-paral').append(o);
                
            } else {
                $('#roz-paral').children().remove().end().append('<option value="0"/>');
                PopulateDays( $("#get-ceremony-paral").val(), 1 );
            }
            
        });    
        
        $('#gah').on('change', function (e) {
            var $valueSelected  = this.value;
            $('#mah').children().remove().end().append('<option value="-1"/>');
            if ( $valueSelected == 1 ) {
                PopulateMonths( 0, 0, 1 );
            } else {
                PopulateMonths( 0, 0, 0 );
            }
            //if  ( !( $('#mah').is(':disabled') ) ) {
            //      $('#mah').val(1);
            //}
        });
        
        $('#gah-paral').on('change', function (e) {
            var $valueSelected  = this.value;
            $('#mah-paral').children().remove().end().append('<option value="-1"/>');
            if ( $valueSelected == 1 ) {
                PopulateMonths( 0, 1, 1 );
            } else {
                PopulateMonths( 0, 1, 0 );
            }
            //if  ( !( $('#mah-paral').is(':disabled') ) ) {
            //    $('#mah-paral').val(1);
            //}
        });        
    
    });

    function PopulateKhordehCeremonies( $gettype )
    {
       EmptyKhordehSelectors();
        
       if ( $gettype == 0 ) {
           $('#selector-main-khordeh').val(-1); 
       }
       
        $('#get-ceremony-khordeh').children().remove().end().append('<option value="-1"/>'); 
       
       if ( $gettype == 1 ) {

            $("#khordeh_ceremony").removeClass('col-lg-9').addClass('col-lg-4');           

            $('#khordeh_type').css('display','block');   
            $('#khordeh_gah').css('display','block');
           
            var o = new Option("Ashem Vohu", "0");                     // AV
            $('#get-ceremony-khordeh').append(o);  
           
            var o = new Option("Ahuna Vairya", "1");                   // YAV
            $('#get-ceremony-khordeh').append(o);  

            var o = new Option("Bāj Gomēz Kardan", "2");
            $('#get-ceremony-khordeh').append(o);             
            var o = new Option("Bāj Nan Xordan (short version)", "3");
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Bāj Nan Xordan (longer version for Priests)", "4");
            $('#get-ceremony-khordeh').append(o);
         
            var o = new Option("Nērang Kostï Bastan", "5");            // NerKB
            $('#get-ceremony-khordeh').append(o); 
            var o = new Option("Srōsh Bāj", "6");                        // SrB
            $('#get-ceremony-khordeh').append(o);  
           
            var o = new Option("Niyāyishn Xwarshēd", "7");                // NyXwar
            $('#get-ceremony-khordeh').append(o);           
            var o = new Option("Niyāyishn Mihr", "8");                   // NyMihr
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Niyāyishn Māh", "9");                    //NyMah
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Niyāyishn Ātash", "10");                   //NyAtash
            $('#get-ceremony-khordeh').append(o);            
           
            var o = new Option("Yasht Ohrmazd", "11");
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Yasht Ardwahisht", "12");
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Nērang Yasht Ardwahisht (Parsi)", "300");
            $('#get-ceremony-khordeh').append(o);
            
            var o = new Option("Yasht Srōsh Hadōxt", "13");
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Yasht Srōsh", "14");
            $('#get-ceremony-khordeh').append(o);
          
             var o = new Option("Gāh Ushahin", "15");
            $('#get-ceremony-khordeh').append(o);            
            var o = new Option("Gāh Hāwan", "16");
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Gāh Rapithwin", "17");
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Gāh Uzērin", "18");
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Gāh Ēbsrūsrīm", "19");
            $('#get-ceremony-khordeh').append(o);
         
            var o = new Option("Nām Stāyishn (Pazand)", "20");           // NamSt
            $('#get-ceremony-khordeh').append(o);  
            //var o = new Option("Nām Stāyishn (Parsi) TO HIDE", "21");            // NamSt
            //$('#get-ceremony-khordeh').append(o); 
            var o = new Option("Nām Stāyishn (Pahlavi)", "22");          // NamSt
            $('#get-ceremony-khordeh').append(o); 

            //var o = new Option("Patit Īrānī TO HIDE", "23");                     // NamSt
            //$('#get-ceremony-khordeh').append(o);  
            var o = new Option("Hōshbām", "24");                      // HO
            $('#get-ceremony-khordeh').append(o);  
            var o = new Option("Namaskar Cahār Nēmag", "25");        // NCN
            $('#get-ceremony-khordeh').append(o);            
            var o = new Option("Vīspa Humata", "26");                    // VH
            $('#get-ceremony-khordeh').append(o);  
            var o = new Option("Yasht Hōm", "27");
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Yasht Wanand", "28");
            $('#get-ceremony-khordeh').append(o);  

       } else if ( $gettype == 2 )  {

            $("#khordeh_ceremony").removeClass('col-lg-9').addClass('col-lg-4');           

            $('#khordeh_dedicatory').css('display','block');   
            $('#khordeh_gah').css('display','block');


            var o = new Option("Nērang Nāxon Cīdan", "100");
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Nērang Sheytān Bāzī", "101");
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Nērang ʿAtse (Pazand)", "102");
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Nērang ʿAtse (Parsi)", "103");
            $('#get-ceremony-khordeh').append(o);


            
            var o = new Option("Mayā Yasht", "104");
            $('#get-ceremony-khordeh').append(o);  
            
            var o = new Option("Niyāyishn Ābān", "150");
            $('#get-ceremony-khordeh').append(o);     
            
            var o = new Option("Āfrīnagān Dahmān", "105");
            $('#get-ceremony-khordeh').append(o);  
            var o = new Option("Āfrīnagān Gāhāmbār", "106");
            $('#get-ceremony-khordeh').append(o);  
            var o = new Option("Āfrīnagān Gāthā", "107");
            $('#get-ceremony-khordeh').append(o);  
            var o = new Option("Āfrīnagān Rapithwin", "108");
            $('#get-ceremony-khordeh').append(o);  
            var o = new Option("Āfrīnagān Nōg Nāwar", "109");
            $('#get-ceremony-khordeh').append(o); 
            //var o = new Option("Āfrīn Rapithwin X", "110");
            //$('#get-ceremony-khordeh').append(o); 
            var o = new Option("Cithram Būyād (Pazand)", "111");
            $('#get-ceremony-khordeh').append(o); 
            var o = new Option("Cithram Būyād (Parsi)", "112");
            $('#get-ceremony-khordeh').append(o);             
            
            var o = new Option("Yasht Wahrām", "113");                   
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Yasht Amesha Spenta", "114");                   
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Yasht Hordad", "115");                   
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Doʿā Ziyān-e Mardomān", "125");                   
            $('#get-ceremony-khordeh').append(o);
            //var o = new Option("Yasht Hordād TO HIDE", "115");                   
            //$('#get-ceremony-khordeh').append(o);            
            //var o = new Option("Yasht Frawahr TO HIDE", "116");                   
            //$('#get-ceremony-khordeh').append(o);      
            
             var o = new Option("Sēpās-e Aōi (Pazand)", "117");                   
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Sēpās-e Aōi (Parsi)", "118");                   
            $('#get-ceremony-khordeh').append(o);
             var o = new Option("Pad Nām Dādār Ohrmazd (Pazand) (= Be Nām-e Yazd)", "119");                   
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Pad Nām Dādār Ohrmazd (Parsi) (= Be Nām-e Yazd)", "120");                   
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Nām-e Xāwar (Pazand)", "121");                   
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Nām-e Xāwar (Parsi)", "122");                   
            $('#get-ceremony-khordeh').append(o);     
             var o = new Option("Namāz Urmazd (Pāzand)", "123");                   
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Namāz Urmazd (Parsi)", "124");                   
            $('#get-ceremony-khordeh').append(o);      
            //dozyan goes here
             var o = new Option("Karde Sroš", "126");                   
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Karde Sroš Rawan", "127");                   
            $('#get-ceremony-khordeh').append(o);              
            
            // Misc
            var o = new Option("Nērang Barsom Cīdan", "200");
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Nērang Jam Duxtan", "201");
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Nērang Zur Gereftan", "202");
            $('#get-ceremony-khordeh').append(o);
            var o = new Option("Nērang Waras", "203");
            $('#get-ceremony-khordeh').append(o);

       }
       
    }

    function PopulateCeremonies( $gettype )
    {
        $('#get-ceremony').children().remove().end().append('<option value="-1"/>');
        EmptySelectors( 0 );
        
        if ( $gettype == 3 )    {
            var o = new Option("Paragna", "10");
            $('#get-ceremony').append(o);
        
        } if ( $gettype == 2 )  {
            var o = new Option("Drōn Yasht", "0");
            $('#get-ceremony').append(o);
            
            var o = new Option("Homast Paragna", "9");
            $('#get-ceremony').append(o);
            
        } else if ( $gettype == 1 ) {
            var o = new Option("Yasna Rapithwin", "1");
            $('#get-ceremony').append(o);
            var o = new Option("Yasna", "2");
            $('#get-ceremony').append(o);
            var o = new Option("Visperad", "3");
            $('#get-ceremony').append(o);            
            var o = new Option("Visperad Do-Homast", "11");
            $('#get-ceremony').append(o);  
            var o = new Option("Videvdad", "4");
            $('#get-ceremony').append(o);
            var o = new Option("Vištasp Yašt", "5");
            $('#get-ceremony').append(o);     
            
        } else if ( $gettype == 0 ) {
            return;
        }
    }    
    
    function PopulateDays( $y, $hasparal, $dedic )
    {
        var $extra = '';
        if ( $hasparal == 1 )   {
            $extra = "-paral";
        }
        
        
        var $dedicatory = $('#dedicatory' + $extra).children(":selected").attr("value");
        
        if ( $dedic )   {
            $dedicatory = $dedic;
        }

        if ( $dedicatory != 40 )    {
            
            // populate days
            var o = new Option("1. Dadvah Ohrmazd", "1");
            $('#roz' + $extra).append(o);
            var o = new Option("2. Wahman", "2");
            $('#roz' + $extra).append(o);
            var o = new Option("3. Ardwahišt", "3");
            $('#roz' + $extra).append(o);
            var o = new Option("4. Šahrewar", "4");
            $('#roz' + $extra).append(o);
            var o = new Option("5. Spandarmad", "5");
            $('#roz' + $extra).append(o);
            var o = new Option("6. Hordād", "6");
            $('#roz' + $extra).append(o);
            var o = new Option("7. Amurdād", "7");
            $('#roz' + $extra).append(o);
            var o = new Option("8. Day pad Ādur", "8");
            $('#roz' + $extra).append(o);
            var o = new Option("9. Ādur", "9");
            $('#roz' + $extra).append(o);
            var o = new Option("10. Ābān", "10");
            $('#roz' + $extra).append(o);
            var o = new Option("11. Xwar", "11");
            $('#roz' + $extra).append(o);
            var o = new Option("12. Māh", "12");
            $('#roz' + $extra).append(o);
            var o = new Option("13. Tīr", "13");
            $('#roz' + $extra).append(o);
            var o = new Option("14. Gōš", "14");
            $('#roz' + $extra).append(o);
            var o = new Option("15. Day pad Mihr", "15");
            $('#roz' + $extra).append(o);
            var o = new Option("16. Mihr", "16");
            $('#roz' + $extra).append(o);
            var o = new Option("17. Srōš", "17");
            $('#roz' + $extra).append(o);
            var o = new Option("18. Rašn", "18");
            $('#roz' + $extra).append(o);
            var o = new Option("19. Frawardīn", "19");
            $('#roz' + $extra).append(o);
            var o = new Option("20. Wahrām", "20");
            $('#roz' + $extra).append(o);
            var o = new Option("21. Rām", "21");
            $('#roz' + $extra).append(o);
            var o = new Option("22. Wād", "22");
            $('#roz' + $extra).append(o);
            var o = new Option("23. Day pad Dēn", "23");
            $('#roz' + $extra).append(o);
            var o = new Option("24. Dēn", "24");
            $('#roz' + $extra).append(o);
            var o = new Option("25. Ard", "25");
            $('#roz' + $extra).append(o);
            var o = new Option("26. Aštād", "26");
            $('#roz' + $extra).append(o);
            var o = new Option("27. Asmān", "27");
            $('#roz' + $extra).append(o);
            var o = new Option("28. Zāmyād", "28");
            $('#roz' + $extra).append(o);
            var o = new Option("29. Māraspand", "29");
            $('#roz' + $extra).append(o);
            var o = new Option("30. Anagrān", "30");
            $('#roz' + $extra).append(o);    
        }        
        
        
        if ( ( $dedicatory == 40 ) || ( $dedicatory == 42 ) ) {
           if ( $y != 4 )    { 
                var o = new Option("I. Ahunauuaitī Gāθā", "31");
                $('#roz' + $extra).append(o);    
                var o = new Option("II. UštauuaitīGāθā", "32");
                $('#roz' + $extra).append(o);    
                var o = new Option("III. Spə̄ṇtāmańiiu Gāθā", "33");
                $('#roz' + $extra).append(o);    
                var o = new Option("IV. Vohuxšaθrā Gāθā", "34");
                $('#roz' + $extra).append(o);    
                var o = new Option("V. Vahištōišti Gāθā", "35");
                $('#roz' + $extra).append(o);    
           }
        }
    };    
    
    
    function PopulateDedicatoryVidevdad( $hasparal )
    {
        var $extra = '';
        if ( $hasparal == 1 )   {
            $extra = "-paral";
        }
        
        var o = new Option("1. Ohrmazd", "1");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("2. Wahman", "2");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("3. Ardwahišt", "3");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("4. Šahrewar", "4");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("5. Spandarmad", "5");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("6. Khordād", "6");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("7. Amurdād", "7");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("8. Dae-pa-ādar", "8");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("9. Ādar", "9");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("10. Ābān", "10");
        $('#dedicatory' + $extra).append(o);
        
        var o = new Option("11. Xwaršēd", "11");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("12. Māh", "12");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("13. Tīr", "13");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("14. Goš", "14");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("15. Dae-pa-mihr", "15");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("16. Mihr Standard", "16");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("17. Bāj Mihrgān Indian", "17");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("18. Mihrgān Persian Rivayat", "18");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("19. Srōš", "19");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("20. Rašn", "20");
        $('#dedicatory' + $extra).append(o);        
        
        var o = new Option("21. Frawardīn", "21");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("22. Wahrām", "22");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("23. Rām", "23");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("24. Wād", "24");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("25. Dae-pa-dēn", "25");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("26. Dēn", "26");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("27. Ard", "27");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("28. Āštād", "28");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("29. Āsmān", "29");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("30. Zam", "30");
        $('#dedicatory' + $extra).append(o);  
        
        var o = new Option("41. Gāhānbār", "42");
        $('#dedicatory' + $extra).append(o);    
        
    }
    
    function PopulateDedicatory( $y, $hasparal )
    {
        var $extra = '';
        if ( $hasparal == 1 )   {
            $extra = "-paral";
        }
        
        if ( $y == 9 )  {
            $('#dedicatory').prop('disabled', true ); 
            return 0;
        
        } else {
            $('#dedicatory').prop('disabled', false );
        }
        
        var o = new Option("1. Ahura Mazdā", "1");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("2. Wahman", "2");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("3. Ardwahišt", "3");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("4. Šahrewar", "4");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("5. Spandarmad", "5");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("6. Khordād", "6");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("7. Amurdād", "7");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("8. Dae-pa-ādar", "8");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("9. Ādar", "9");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("10. Ābān", "10");
        $('#dedicatory' + $extra).append(o);
        
        var o = new Option("11. Xwaršēd", "11");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("12. Māh", "12");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("13. Tīr", "13");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("14. Goš", "14");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("15. Dae-pa-mihr", "15");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("16. Mihr Standard", "16");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("17. Bāj Mihrgān Indian", "17");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("18. Mihrgān Persian Rivayat", "18");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("19. Srōš", "19");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("20. Rašn", "20");
        $('#dedicatory' + $extra).append(o);        
        
        var o = new Option("21. Frawardīn", "21");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("22. Wahrām", "22");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("23. Rām", "23");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("24. Wād", "24");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("25. Dae-pa-dēn", "25");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("26. Dēn", "26");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("27. Ard", "27");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("28. Āštād", "28");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("29. Āsmān", "29");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("30. Zam", "30");
        $('#dedicatory' + $extra).append(o);        
        
        var o = new Option("31. Māraspand", "31");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("32. Anērān", "32");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("33. Burz", "33");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("34. Hōm", "34");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("35. Dahm", "35");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("36. Vanant", "36");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("37. Nairyosangh", "37");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("38. Haptoiring", "38");
        $('#dedicatory' + $extra).append(o);
        
        if ( $y != 2 )  {
            var o = new Option("39. Rapiθβin", "39");
            $('#dedicatory' + $extra).append(o);
        }
        
        var o = new Option("40. Gāthā", "40");
        $('#dedicatory' + $extra).append(o);
        //var o = new Option("41. Gāthās Panj-tāe", "41");
        //$('#dedicatory' + $extra).append(o);
        
        
        
        if ( ! ["0", "2"].includes( $y ) )   {
            var o = new Option("41. Gāhānbār", "42");
            $('#dedicatory' + $extra).append(o);    
        }
        
        var o = new Option("42. Panth", "43");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("43. Hamkār rōz Ohrmazd, Dae-pa-ādar, Dae-pa-mehr, Dae-pa-dēn. Hōm", "44");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("44. Hamkār rōz Wahman, Māh, Goš, Rām", "45");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("45. Hamkār rōz Ardwahišt, Ādar, Srōš, Wahrān", "46");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("46. Hamkār rōz Šahrewar, Xvaršēd, Mihr, Āsman, Anērān", "47");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("47. Hamkār rōz Spandarmad, Ābān, Dēn, Ard, Mahraspand", "48");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("48. Hamkār rōz Xordād, Tīr, Frawardēn, Vād", "49");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("49. Hamkār rōz Amurdād, Rašn, Āštād, Zamyād", "50");
        $('#dedicatory' + $extra).append(o);
    
        var o = new Option("50. Sīrōzā", "51");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("51. Ameša Spenta", "52");
        $('#dedicatory' + $extra).append(o);
       // var o = new Option("53. Shahen = Sīrōzā + Srōš + Frawardēn in each part of the Bāj", "53");
        //$('#dedicatory').append(o);
        var o = new Option("52. Mēnōg Nāvār", "54");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("53. Dēn beh Mīnō Māhraspand", "55");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("54. Welcoming guests", "56");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("55. Xōrdād Sāl", "57");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("56. Avardād Sāl Gāh", "58");
        $('#dedicatory' + $extra).append(o);
        var o = new Option("57. Rašn-Āštād", "59");
        $('#dedicatory' + $extra).append(o);
        //var o = new Option("60. Dahm (Afrinagan)", "60");
        //$('#dedicatory').append(o);        
        
    };
    
    function PopulateKhordehDedicatory( $y, $hasparal )
    {
        $('#dedicatory-khordeh').prop('disabled', false );
        
        if ( $y == 0 )  {
            var o = new Option("1. Ahura Mazdā", "1|1" );
            $('#dedicatory-khordeh').append(o);
            var o = new Option("3. Ardwahišt", "3|3" );
            $('#dedicatory-khordeh').append(o);
        } else if ( $y == 1 )   {
            var o = new Option("1. Xwaršēd", "1|11" );
            $('#dedicatory-khordeh').append(o);
            var o = new Option("2. Mihr", "2|16" );
            $('#dedicatory-khordeh').append(o);        
        } else if ( ( $y >= 5 ) || ( $y <=8 ) )   {
            $('#dedicatory-khordeh').prop('disabled', true);
        }
        
    }
    
    function PopulateKhordehType( $y, $hasparal )
    {
        $('#type-khordeh').prop('disabled', false );

        if ( [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "116", "117", "118", "119", "120", "121", "122", "123", "124", "126", "127", "200", "201", "202", "203", "300" ].includes( $y ) ) {
            var o = new Option("Iranian", "1" );
            $('#type-khordeh').append(o); 
            $('#type-khordeh').prop('disabled', true );
        } else if ( [ "24", "25", "26", "27", "28", "114", "150" ].includes( $y ) ) {
            var o = new Option("Indian", "2" );
            $('#type-khordeh').append(o); 
            $('#type-khordeh').prop('disabled', true );
        } else {
            var o = new Option("Iranian", "1" );
            $('#type-khordeh').append(o);
            var o = new Option("Indian", "2" );
            $('#type-khordeh').append(o);            
        }

        //$('#type-khordeh').prop('disabled', true);
        
    }
    
    function PopulateMonths( $valueSelected, $hasparal, $rapth )
    {
        $('#mah' + $extra).children().remove().end().append('<option value="0"/>');

        var $extra = '';
        if ( $hasparal == 1 )   {
            $extra = "-paral";
        }        

        // populate months
        var o = new Option("1. Frawardin", "1");
        $('#mah' + $extra).append(o);
        var o = new Option("2. Ardwahisht", "2");
        $('#mah' + $extra).append(o);
        var o = new Option("3. Khordad", "3");
        $('#mah' + $extra).append(o);
        var o = new Option("4. Tir", "4");
        $('#mah' + $extra).append(o);
        var o = new Option("5. Amurdad", "5");
        $('#mah' + $extra).append(o);
        var o = new Option("6. Shahrewar", "6");
        $('#mah' + $extra).append(o);
        
        if ( ( $valueSelected != 1 ) && ( $rapth != 1 ) ) {        

            var o = new Option("7. Mihr", "7");
            $('#mah' + $extra).append(o);
            var o = new Option("8. Aban", "8");
            $('#mah' + $extra).append(o);
            var o = new Option("9. Adur", "9");
            $('#mah' + $extra).append(o);
            var o = new Option("10. Dae", "10");
            $('#mah' + $extra).append(o);
            var o = new Option("11. Wahman", "11");
            $('#mah' + $extra).append(o);
            var o = new Option("12. Spendarmad", "12");
            $('#mah' + $extra).append(o);
            
        }    
      
        $('#mah' + $extra).val(1);
        
    };
    
    function SelectKhordehSpecific( $ceremony, $hasparal )
    {
        $y = $ceremony;
    
        
        if ( [ "14", "15" ].includes( $y ) ) {
            $('#gah-khordeh').val(4);
        } else if ( [ "16" ].includes( $y ) ) {      // might add extra condition later
            $('#gah-khordeh').val(0);
        } else if ( [ "17", "108", "110" ].includes( $y ) ) {      // might add extra condition later
            $('#gah-khordeh').val(1);
        } else if ( [ "18", "127" ].includes( $y ) ) {      // might add extra condition later
            $('#gah-khordeh').val(2);    
        } else if ( [ "19" ].includes( $y ) ) {      // might add extra condition later
            $('#gah-khordeh').val(3);    
        } else if ( [ "0", "1", "3", "20", "22","25", "26", "101", "102", "103", "111", "112", "117", "118", "119", "120", "121", "122", "123", "124" ].includes( $y ) ) {
            $('#gah-khordeh').val(10);
        } else {
            $('#gah-khordeh').val(0);
        }
        
        if ( [ "24", "25", "26", "27", "28", "114", "150" ].includes( $y ) ) {
            $('#type-khordeh').val(2);
        } else {
            $('#type-khordeh').val(1);
        }
        
    }
    
    function SelectSpecific( $ceremony, $hasparal )
    {
        var $extra = '';
        if ( $hasparal == 1 )   {
            $extra = "-paral";
        }
        
        
        if ( ( $ceremony == 0 ) || ( $ceremony == 9 ) || ( $ceremony == 10 ) ) {
             
            $('#dedicatory' + $extra).val(21); 
            $('#gah' + $extra).val(0);
            $('#roz' + $extra).val(1);
            $('#mah' + $extra).val(1);
            
        } else if ( $ceremony == 1 ) {
            
            $('#dedicatory' + $extra).val(39); 
            $('#gah' + $extra).val(2);
            $('#roz' + $extra).val(3);
            $('#mah' + $extra).val(1);            
            
        } else if ( $ceremony == 2 ) {
        
            $('#dedicatory' + $extra).val(54); 
            $('#gah' + $extra).val(0);
            $('#roz' + $extra).val(1);
            $('#mah' + $extra).val(1);            
            
        } else if ( ( $ceremony == 3 ) || ( $ceremony == 11 ) ) {
            
            $('#dedicatory' + $extra).val(42); 
            $('#gah' + $extra).val(0);
            $('#roz' + $extra).val(12);
            $('#mah' + $extra).val(2);        
            
            var o = new Option("I. Ahunauuaitī Gāθā", "31");
            $('#roz' + $extra).append(o);    
            var o = new Option("II. UštauuaitīGāθā", "32");
            $('#roz' + $extra).append(o);    
            var o = new Option("III. Spə̄ṇtāmańiiu Gāθā", "33");
            $('#roz' + $extra).append(o);    
            var o = new Option("IV. Vohuxšaθrā Gāθā", "34");
            $('#roz' + $extra).append(o);    
            var o = new Option("V. Vahištōišti Gāθā", "35");
            $('#roz' + $extra).append(o);   
        
        } else if ( $ceremony == 4 ) {

            $('#dedicatory' + $extra).val(19); 
            $('#gah' + $extra).val(4);
            $('#roz' + $extra).val(1);
            $('#mah' + $extra).val(1);                

        } else if ( $ceremony == 5 ) {
        
            $('#dedicatory' + $extra).val(26); 
            var o = new Option("Ushahin", "4");
            //$('#gah' + $extra).append(o);
            if ( $extra )   {
                $("#gah-paral option:first").after(o);
            } else {
                $("#gah option:first").after(o);
            }
            
            $('#gah' + $extra).val(4);
            $('#roz' + $extra).val(1);
            $('#mah' + $extra).val(1);     
        
        }
    
    }

    function PopulateKhordehGah( $y , $paral )
    {
        $('#gah-khordeh').prop('disabled', false );

        
        if ( [ "15", "16", "17", "18", "19" ].includes( $y ) ) {    // remove 2??
            $('#gah-khordeh').prop('disabled', true );
        }
        
        if ( [ "0", "1", "3", "20", "22", "25", "26", "101", "102", "103", "111", "112", "117", "118", "119", "120", "121", "122", "123", "124" ].includes( $y ) ) {
            $('#gah-khordeh').prop('disabled', true );  // keep it separete in case we add different conditions later   
        }

        if ( ["7", "8" ].includes( $y ) ) {
            var o = new Option("Hawan", "0");
            $('#gah-khordeh').append(o);
            var o = new Option("Rapithwin", "1");
            $('#gah-khordeh').append(o);
            var o = new Option("Uzerin", "2");
            $('#gah-khordeh').append(o);
        } else if ( $y == 15 ) {
            var o = new Option("Ushahin", "4");
            $('#gah-khordeh').append(o);
        } else if ( $y == 16 ) {
            var o = new Option("Hawan", "0");
            $('#gah-khordeh').append(o);            
        } else if ( ( $y == 17 ) || ( $y == 108 ) || ( $y == 110 ) ){
            var o = new Option("Rapithwin", "1");
            $('#gah-khordeh').append(o);            
        } else if ( ( $y == 18 ) || ( $y == 127 ) ) {
            var o = new Option("Uzerin", "2");
            $('#gah-khordeh').append(o);            
        } else if ( $y == 19 ) {
            var o = new Option("Aiwisruthrem", "3");
            $('#gah-khordeh').append(o);  
        } else if ( [ "0", "1", "3", "20", "22", "25", "26", "101", "102", "103", "111", "112", "117", "118", "119", "120", "121", "122", "123", "124" ].includes( $y ) ) {
            var o = new Option("", "10");       // make it seem like nothing is selected
            $('#gah-khordeh').append(o);
        } else if ( [ "12", "300" ].includes( $y ) ) {
            var o = new Option("Ushahin", "4");
            $('#gah-khordeh').append(o);        
            var o = new Option("Hawan", "0");
            $('#gah-khordeh').append(o);
            var o = new Option("Aiwisruthrem", "3");
            $('#gah-khordeh').append(o);
        } else if ( $y == 11 ) {
            var o = new Option("Ushahin", "4");
            $('#gah-khordeh').append(o);        
            var o = new Option("Hawan", "0");
            $('#gah-khordeh').append(o);
            var o = new Option("Rapithwin", "1");
            $('#gah-khordeh').append(o);
            var o = new Option("Aiwisruthrem", "3");
            $('#gah-khordeh').append(o);            
            
        } else if ( $y == 13 ) {    
            var o = new Option("Ushahin", "4");
            $('#gah-khordeh').append(o);        
            var o = new Option("Hawan", "0");
            $('#gah-khordeh').append(o);
            var o = new Option("Uzerin", "2");
            $('#gah-khordeh').append(o);            
            var o = new Option("Aiwisruthrem", "3");
            $('#gah-khordeh').append(o);
        } else if ( $y == 14 ) {    
            var o = new Option("Ushahin", "4");
            $('#gah-khordeh').append(o);        
            var o = new Option("Aiwisruthrem", "3");
            $('#gah-khordeh').append(o);            

        } else {
            var o = new Option("Ushahin", "4");
            $('#gah-khordeh').append(o);        
            var o = new Option("Hawan", "0");
            $('#gah-khordeh').append(o);
            var o = new Option("Rapithwin", "1");
            $('#gah-khordeh').append(o);
            var o = new Option("Uzerin", "2");
            $('#gah-khordeh').append(o);
            var o = new Option("Aiwisruthrem", "3");
            $('#gah-khordeh').append(o);        
        }

    };

    function PopulateGah( $y , $hasparal )
    {

        var $extra = '';
        if ( $hasparal == 1 )   {
            $extra = "-paral";
        }
        
        // populate gah
        if ( ! ["1", "2", "5"].includes( $y ) )  {
            
            var o = new Option("Ushahin", "4");
            $('#gah' + $extra).append(o);        
            
        }         
         
        if ( ! ["1", "4"].includes( $y ) ) {
            var o = new Option("Hawan", "0");
            $('#gah' + $extra).append(o);
        }

        if ( ! ["2", "4"].includes( $y ) ) {        
            var o = new Option("Rapithwin", "2");
            $('#gah' + $extra).append(o);
        }
        
        if ( ! ["1", "4"].includes( $y ) ) {
            var o = new Option("Uzerin", "2");
            $('#gah' + $extra).append(o);
        }
        
        if ( ! ["1", "2", "4"].includes( $y ) ) {
            var o = new Option("Aiwisruthrem", "3");
            $('#gah' + $extra).append(o);        
        }
        

    };
    
    function EmptyKhordehSelectors( $hasparal )
    {
        $('#gah-khordeh').children().remove().end().append('<option value="0"/>');
        $('#type-khordeh').children().remove().end().append('<option value="0"/>');
    }
    
    function EmptyKhordehSelectors( )
    {
        $('#gah-khordeh').children().remove().end().append('<option value="-1"/>');
        $('#type-khordeh').children().remove().end().append('<option value="0"/>');
    }
    
    function EmptySelectors( $hasparal )
    {
        var $extra = '';
        if ( $hasparal == 1 )   {
            $extra = "-paral";
        }
        
        $('#roz' + $extra).children().remove().end().append('<option value="0"/>');       
        $('#mah' + $extra).children().remove().end().append('<option value="0"/>');
        $('#dedicatory' + $extra).children().remove().end().append('<option value="0"/>');
        $('#gah' + $extra).children().remove().end().append('<option value="-1"/>');
    };  
    
    function SyncParal( $getceremony, $roz, $mah, $gah, $dedicatory )
    {
        EmptySelectors( 1 );
        
        $('#get-ceremony-paral').val($getceremony);

        PopulateDedicatory( $getceremony, 1 );
        PopulateDays( $getceremony, 1, $dedicatory );
        PopulateMonths( $getceremony, 1, 0 );
        
        $('#roz-paral').val($roz);

        if ( $getceremony == 1 )  {
            $('#dedicatory-paral').children().remove().end().append('<option value="0"/>');
            
            var o = new Option("39. Rapiθβin", "39");
            $('#dedicatory-paral').append(o);
    
        } else if ( $getceremony == 4 ) { // videvdad
            $('#dedicatory-paral').children().remove().end().append('<option value="0"/>');
            
            //var o = new Option("1. Ahura Mazdā", "1");
            //$('#dedicatory-paral').append(o);
            //var o = new Option("19. Srōš", "19");
            //$('#dedicatory-paral').append(o);
            //var o = new Option("21. Frawardēn", "21");
            //$('#dedicatory-paral').append(o); 
            PopulateDedicatoryVidevdad( 1 );
        } 
        
        $('#dedicatory-paral').val($dedicatory);

        if ( $mah == 0 ) {
            $('#mah-paral').prop('disabled', true);
        } else {
            $('#mah-paral').prop('disabled', false);
            $('#mah-paral').val($mah);    
        }
        
        PopulateGah( $getceremony, 1 );
        $('#gah-paral').val($gah);
        
    };