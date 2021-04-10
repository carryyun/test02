<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
const options = {method: 'GET'};

fetch('https://api.upbit.com/v1/ticker?markets=KRW-BTC', options)
	.then( response => {
		console.log(response.json);
		console.log("성공!");
	}).catch(err => console.error(err));
	
	
const url = 'https://api.upbit.com/v1/trades/ticks';
    let qs = {market:market};
    if (to) qs.to = to;
    if (count) qs.count = count;

    let result = await request(url, qs);
    console.log(result);
</script>

</head>
<body>



Hi
</body>
</html>