xquery version "3.1";

declare variable $nerang_video_id := request:get-parameter( 'id'  , '0' );

let $media := for $i in collection( "/db/apps/cab_db/cab_media/" )/media_library/media[data(id) eq $nerang_video_id]
                return $i


return
    <nerang_media>
        <div class="tab_float">
            <div class="tab_header">
                <h5>{$media/name}</h5>
            </div>
            { if ( data($media/type) eq "img" ) then (
                    <div class="gallery_item gallery_image" style="height:90%">
                        <img src="{fn:concat( "https://cab.geschkult.fu-berlin.de/exist/apps/cab_db/" , $media/link )}" style="object-fit:contain;width:100%" />
                    </div>    
                ) else if ( data($media/type) eq "vid" )  then (
                    <div class="gallery_item gallery_video" style="height:90%">
                          <iframe width="100%" height="100%" src="{$media/link}" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"/>
                    </div>
                ) else () }
            <div style="text-align:right">
                 <p>( For more info or to see the media full-page <a href="./gallery.html?media_id={data($nerang_video_id)}" target="_blank" class="uilink">click here</a> )</p>
            </div> 
        </div>
    </nerang_media>