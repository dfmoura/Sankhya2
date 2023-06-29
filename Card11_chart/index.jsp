<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Line Chart Example</title>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<link src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.js"></script>
	<link src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<snk:load/>	
  <style>
    canvas {
      display: block;
      margin: 0 auto;
    }
  </style>
</head>
<body>
  <canvas id="lineChart"></canvas>

  <%
    // Java code to retrieve data from the Oracle SQL query
    try {
      // Assuming you have established a connection and created a statement
      ResultSet resultSet = statement.executeQuery("SELECT DTMOV, Saidas, Devolucoes, Servicos, Total FROM (SELECT DISTINCT CAB.DTMOV, SUM(CASE WHEN CAB.CODTIPOPER IN (1100, 1112, 1152) THEN VLRNOTA ELSE 0 END) AS Saidas, SUM(CASE WHEN CAB.CODTIPOPER IN (1200, 1201, 1216, 1217) THEN VLRNOTA * -1 ELSE 0 END) AS Devolucoes, SUM(CASE WHEN CAB.CODTIPOPER IN (1105) THEN VLRNOTA ELSE 0 END) AS Servicos, SUM(CASE WHEN CAB.CODTIPOPER IN (1100, 1112, 1152) THEN VLRNOTA ELSE 0 END) + SUM(CASE WHEN CAB.CODTIPOPER IN (1200, 1201, 1216, 1217) THEN VLRNOTA * -1 ELSE 0 END) + SUM(CASE WHEN CAB.CODTIPOPER IN (1105) THEN VLRNOTA ELSE 0 END) AS Total FROM TGFCAB CAB INNER JOIN TSIEMP EMP ON CAB.CODEMP = EMP.CODEMP INNER JOIN TSIEND ENDI ON EMP.CODEND = ENDI.CODEND INNER JOIN TSIBAI BAI ON EMP.CODBAI = BAI.CODBAI INNER JOIN TSICID CID ON EMP.CODCID = CID.CODCID INNER JOIN TSIUFS UFS ON CID.UF = UFS.CODUF WHERE (CAB.DTMOV >= TO_DATE('01-12-2022', 'DD-MM-YYYY') AND CAB.DTMOV <= TO_DATE('29-06-2023', 'DD-MM-YYYY')) AND CAB.CODTIPOPER IN (1100, 1112, 1152, 1200, 1201, 1216, 1217, 1105) AND CAB.CODEMP = 60 AND CAB.STATUSNOTA = 'L' GROUP BY CAB.DTMOV ORDER BY CAB.DTMOV)");

      // Initialize arrays to store data
      List<String> dates = new ArrayList<>();
      List<Integer> saidas = new ArrayList<>();
      List<Integer> devolucoes = new ArrayList<>();
      List<Integer> servicos = new ArrayList<>();
      List<Integer> total = new ArrayList<>();

      // Fetch data from the result set
      while (resultSet.next()) {
        dates.add(resultSet.getString("DTMOV"));
        saidas.add(resultSet.getInt("Saidas"));
        devolucoes.add(resultSet.getInt("Devolucoes"));
        servicos.add(resultSet.getInt("Servicos"));
        total.add(resultSet.getInt("Total"));
      }

      // Convert Java lists to JavaScript arrays
      String jsDates = dates.toString();
      String jsSaidas = saidas.toString();
      String jsDevolucoes = devolucoes.toString();
      String jsServicos = servicos.toString();
      String jsTotal = total.toString();

      // Pass data to JavaScript for chart rendering
  %>
  <script>
    // JavaScript code to render the line chart
    var ctx = document.getElementById('lineChart').getContext('2d');
    var lineChart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: <%= jsDates %>,
        datasets: [{
          label: 'Saidas',
          data: <%= jsSaidas %>,
          borderColor: 'blue',
          fill: false
        }, {
          label: 'Devolucoes',
          data: <%= jsDevolucoes %>,
          borderColor: 'green',
          fill: false
        }, {
          label: 'Servicos',
          data: <%= jsServicos %>,
          borderColor: 'orange',
          fill: false
        }, {
          label: 'Total',
          data: <%= jsTotal %>,
          borderColor: 'red',
          fill: false
        }]
      },
      options: {
        scales: {
          y: {
            beginAtZero: true
          }
        }
      }
    });
  </script>
  <%
    } catch (SQLException e) {
      e.printStackTrace();
    }
  %>
</body>
</html>
