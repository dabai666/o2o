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
                <div id="-form-item" class="u-fitem clearfix ">
		            <span class="f-tt">
		                 活动名称:
		            </span>
                    <div class="f-boxr">
                        <select id="activity_id" name="activity_id" class="sle   activity_choose">
                            <option value="0">全部</option>
                            @foreach($activity['data'] as $k => $v)
                                <option value="{{$v['id']}}" @if($args['activity_id'] == $v['id']) selected="" @endif>{{$v['name']}}</option>
                            @endforeach
                        </select>
                    </div>
                </div>
                <btn type="search"></btn>
                <!--<linkbtn label="导出当前页到EXCEL" type="export" url="{{ u('ClassifySeckillStatistics/export',$args) }}"></linkbtn>-->
            </row>
        </search>
        <table>
            <thead>
            <tr>
                <td>活动名称</td>
                <td>商品、服务名称</td>
                <td>秒杀价格</td>
                <td>活动（开始-结束）</td>
                <td>销售份数</td>
                <td>销售额</td>
                <td>总库存</td>
            </tr>
            </thead>

            <tbody>
            @foreach ($list as $val)
                <tr>
                    <td>{{$val['activityName']}}</td>
                    <td>{{$val['goodsName']}}</td>
                    <td>{{$val['salePrice'] or $val['price']}}</td>
                    <td>
                        {{ yztime($val['startTime'],'Y-m-d') }} 至 {{ yztime($val['endTime'],'Y-m-d') }}
                    </td>
                    <td>{{$val['totalNum']}}</td>
                    <td>{{$val['totalPrice']}}</td>
                    <td>{{$val['totalStock']}}</td>
                </tr>
            @endforeach
            </tbody>
        </table>
    </yz:list>
    @yizan_end
@stop
@section('js')
    <script>
    </script>
@stop