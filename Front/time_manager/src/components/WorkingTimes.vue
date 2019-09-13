<template>
    <div class="col-sm-6">
            <line-chart
                    id="line" :data="lineData" xkey="year" ykeys='[ "a", "b" ]' resize="true"
                    labels='[ "Serie A", "Serie B" ]' line-colors='[ "#FF6384", "#36A2EB" ]'
                    grid="true" grid-text-weight="bold">
            </line-chart>
        </div>
</template>

<script>
    import Raphael from 'raphael/raphael'
    global.Raphael = Raphael
    import { LineChart} from 'vue-morris'
    export default {
        name: 'WorkingTime',
        data () {
            return {
                lineData: [
        { year: '2013', a: 10, b: 5 },
        { year: '2014', a: 40, b: 15 },
        { year: '2015', a: 20, b: 25 },
        { year: '2016', a: 30, b: 20 },
      ]
            }
        },
        components: {
            LineChart
        },
    }
</script>