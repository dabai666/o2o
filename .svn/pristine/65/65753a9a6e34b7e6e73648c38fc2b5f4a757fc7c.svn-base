@extends('admin._layouts.base')
@section('css')
    <style>
    </style>
@stop
@section('right_content')
    @yizan_begin
    <yz:list>
        <search>
            <row>
                <item label="统计年份">
                    <yz:select name="year" css="year_choose" options="$orderyear" textfield="yearName" valuefield="yearName"  selected="$args['year']"></yz:select>
                </item>
                <item label="月份">
                    <yz:select name="month" css="month_choose" options="1,2,3,4,5,6,7,8,9,10,11,12" texts="1月,2月,3月,4月,5月,6月,7月,8月,9月,10月,11月,12月" selected="$args['month']"></yz:select>
                </item>
                <input name="systemTagListId" type="hidden" value="{{$args['systemTagListId']}}">
                <btn type="search"></btn>
                <a target="_self" class="btn mr5 qipa">

                </a>
            </row>
        </search>
        <table>
            <thead>
            <tr>
                <td>二级标签</td>
                <td>商品名称</td>
                <td>分类名称</td>
                <td>商品品牌</td>
                <td>销售份数</td>
                <td>销售额</td>
                <td>销售重量（kg）</td>
            </tr>
            </thead>

            <tbody>
            <!--<tr>
        		  <td>汇总</td>
        		  <td>{{$total['totalMoney']}}（元）</td>
        		  <td>{{$total['totalNum']}}（单）</td>
        		  <td>{{$total['totalPromotion']}}（元）</td>
        		  <td>{{$total['totalIntegral']}}（分）</td>
        		</tr>-->
            @if($lists)
                @foreach ($lists as $val)
                    <tr>
                        <td>{{$val['tagListName']}}</td>
                        <td>{{$val['goodsName']}}</td>
                        <td>{{$val['name']}}</td>
                        <td>{{$val['shopName']}}</td>
                        <td>{{intval($val['totalNum'])}}</td>
                        <td>{{round($val['totalPrice'],2)}}</td>
                        <td>{{round($val['totalWeight'],2)}}</td>
                    </tr>
                @endforeach
            @else
                <tr>
                    <td colspan="7">  暂无相关数据  </td>
                </tr>
            @endif

            </tbody>
        </table>
    </yz:list>
    @yizan_end
@stop
@section('js')
    <script>
        //$("#yzForm").attr('action',"{{ u('ClassifyBusinessStatistics/detail',$args) }}}");
        $(".qipa").html('导出当前页到EXCEL');
        $(".qipa").attr('href',"{{ u('ClassifyBusinessStatistics/export',['systemTagListId'=>$args['systemTagListId'],'year'=>$args['year'],'month'=>$args['month'],'systemTagListId'=>$args['systemTagListId']]) }}}")
    </script>
@stop