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
				<item label="分类">
					<yz:select name="cateId" css="cateId" options="$cate" textfield="name" valuefield="id"  selected="$args['cateId']"></yz:select>
				</item>
                <btn type="search"></btn>
				<!--<linkbtn label="导出当前页到EXCEL" type="export" url="{{ u('OneselfBusinessStatistics/export',$args) }}"></linkbtn>-->
            </row>
        </search>
        <table pager="no">
    		<thead>
        		<tr>
        		  <td>商品、服务名称</td>
        		  <td>分类</td>
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
				@if($list)
					@foreach ($list as $val)
						<tr>
							<td>{{$val['goodsName']}}</td>
							<td>{{$val['name']}}</td>
							<td>{{intval($val['totalNum'])}}</td>
							<td>{{round($val['totalPrice'],2)}}</td>
							<td>{{round($val['totalWeight'],2)}}</td>
						</tr>
					@endforeach
				@else
					<tr>
						<td colspan="5"> 暂无相关数据</td>
					</tr>
				@endif

    		</tbody>
    	</table>
    </yz:list>
    @yizan_end
@stop
@section('js')
    <script>
    </script>
@stop