@foreach($storageService as $v)
    <div><a class="external" href="@if(strstr($v['url'],'https://')) {{ $v['url'] }} @else {{ 'https://'.$v['url'] }}" @endif><img src="{{ $v['img'] }}" style="margin:10px 10px;width: 95%;border-radius: 5px;"></a></div>
@endforeach