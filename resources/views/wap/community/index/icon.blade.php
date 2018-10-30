@extends('wap.community._layouts.base')

@section('show_top')
    <header class="bar bar-nav">
        <h1 class="title f16">图标字体</h1>
    </header>
@stop
@section('content')
    <div class="content">
        @for($i=0;$i < 10;$i++)
            @for($u=0;$u < 16;$u++)
                <i class="iconfont">&#xe6{{ $i }}@if($u < 10){{ $u }}@elseif($u == 10)a @elseif($u == 11)b @elseif($u == 12)c @elseif($u == 13)d @elseif($u == 14)e @elseif($u == 15)f @endif</i>
                <input type="hidden" value="6{{ $i }}@if($u < 10){{ $u }}@elseif($u == 10)a @elseif($u == 11)b @elseif($u == 12)c @elseif($u == 13)d @elseif($u == 14)e @elseif($u == 15)f @endif" />
            @endfor
        @endfor
        <i class="iconfont">&#xe68a;</i><input type="hidden" value="68a" />
        <i class="iconfont">&#xe68b;</i><input type="hidden" value="68a" />
        <i class="iconfont">&#xe68c;</i><input type="hidden" value="68a" />
        <i class="iconfont">&#xe68d;</i><input type="hidden" value="68a" />
        <i class="iconfont">&#xe68e;</i><input type="hidden" value="68a" />
        <i class="iconfont">&#xe68f;</i><input type="hidden" value="68a" />
        <i class="iconfont">&#xe60f;</i><input type="hidden" value="68a" />

    </div>
@stop