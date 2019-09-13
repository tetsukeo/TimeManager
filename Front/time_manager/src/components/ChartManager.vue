<template>
    <div id="app">
        <donut-chart id="donut" :data="donutData" colors='[ "#FF6384", "#36A2EB" ]' resize="true"></donut-chart>
    </div>
</template>

<script>
    import Raphael from 'raphael/raphael'
    global.Raphael = Raphael
    import { DonutChart} from 'vue-morris'
    export default {
        name: 'ChartManager',
        data () {
            return {
                donutData: [
                    { label: 'Absent', value: 7 },
                    { label: 'Présent', value: 3 }]
            }
        },
        components: {
            DonutChart
        },
    }
</script>

<style scoped>
    h3 {
        color: var(--yellow);
    }
</style>