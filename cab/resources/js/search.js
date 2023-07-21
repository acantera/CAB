    $( document ).ready(function(){
        
        $('#searchavestan').change(function() {
            if(this.checked) {
                $('#cerem_search').val('');
                Deselect();
                
                $('#searchnotes').attr('checked', false );
                
                var searchTerm = $('#cerem_search').val();
                
                if ( isLessThan( searchTerm.length, 3 ) )   {
                    $('#display-viewer').unmark();
                    $('span').unmark();
                    $('note').unmark();                
                    return;
                }  
                
                
                if ( $('#searchlist').attr('checked'))    {
                    $('.tabcontent:icontains(' + searchTerm + ')').css('display', 'block');
                }            
                
                $('#display-viewer').unmark().mark(searchTerm);
            } else {
                $('#display-viewer').unmark();
            }
        });
        
        $('#searchtranslation').change(function() {
            if(this.checked) {
                $('#cerem_search').val('');
                Deselect();
                
                $("#searchlist").attr('checked', false);
                 $('.tabcontent').css('display','block');
                 $('.butpopall').css('display','block');
                $("#searchnotes").attr('checked', false );
                
                var searchTerm = $('#cerem_search').val();
            
               $('.popover-content').unmark().mark(searchTerm);
            } else {
                $('.popover-content').unmark();
            }
        });  
        
        $('#searchnotes').change(function() {
            if(this.checked) {
                $('#cerem_search').val('');
                Deselect();
                
                $('#searchtranslation').attr('checked', false );
                $('#searchavestan').attr('checked', false );
            }
        });
            
        $('#searchlist').change(function() {
            Deselect();
            if(this.checked) {
                    $("#searchtranslation").attr('checked', false);
                    $('#cerem_search').val('');
                    $('div.popover').remove();
                    $('.tabcontent').css('display','none');
                    $('.butpopall').css('display','none');
                    
                    $('#back_to_top').css('display','none');
            } else {
                    $('#cerem_search').val('');
                    $('.tabcontent').css('display','block');
                    $('.butpopall').css('display','block');
                    
                    $('#back_to_top').css('display','block');
            }
        });
        
        $(function() {
            $('input').on('input.highlight', function() {
                
                if ( $('#searchlist').attr('checked'))    {
                    $('.tabcontent').css('display','none');
                }
                            
                // Determine specified search term
                var searchTerm = $(this).val();
                Deselect();   
                
                if ( isLessThan( searchTerm.length, 3 ) )   {
                    $('#display-viewer').unmark();
                    $('span').unmark();
                    $('note').unmark();
                    return;
                }  
                
                
                // Highlight search term inside a specific context
                if ( $('#searchavestan').attr('checked'))    {
                    
                    if ( $('#searchlist').attr('checked'))    {
                        $('ab:icontains(' + searchTerm + ')').closest('.tabcontent').css('display', 'block');
                        $('l:icontains(' + searchTerm + ')').closest('.tabcontent').css('display', 'block');
                        $('note').css('display','block');
                    }
             
                    $('#display-viewer').unmark().mark(searchTerm);
                    $('span').unmark();
                    $('note').unmark();
                } 
                
                if ( $('#searchtranslation').attr('checked') )    {
                    
                    if ( $('#searchlist').attr('checked'))    {
                        $('.popover-content:icontains(' + searchTerm + ')').css('display', 'block');
                    }
                    
                    $('.popover-content').unmark().mark(searchTerm);
                }
                
                if ( $('#searchnotes').attr('checked') )    {
                    var $forSearch = searchTerm;
                    $forSearch = $forSearch.replace('/(','/');
                    $forSearch = $forSearch.replace('/)','/');
                    $forSearch = $forSearch.replace('/[','/');
                    $forSearch = $forSearch.replace('/]','/');
                    
                    if ( $('#searchlist').attr('checked'))    {
                        $('.note:icontains(' + $forSearch + ')').closest('.tabcontent').css('display', 'block');
                        $('note:icontains(' + $forSearch + ')').closest('.tabcontent').css('display', 'block');
                    }
                    
                    $('.note').unmark().mark(searchTerm, {className: 'secondary'});
                    $('note').unmark().mark(searchTerm, {className: 'secondary'});
                }
                
                
            }).trigger('input.highlight').focus();
        });
        
    });