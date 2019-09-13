<template>
    <div>
        <button class="button-work text" v-on:click="ClockManager" v-bind:style="{ backgroundColor: colorClock, color: textColorClock }" v-bind:disabled="btnClock == true">Is working</button>
        <button class="button-work text" v-on:click="ClockManager" v-bind:style="{ backgroundColor: colorUnclock, color: textColorUnclock }" v-bind:disabled="btnClock == false">Is not working</button>
    </div>

</template>
<script>
    export default {
        name: "ClockManager",
        data () {
            return {
                colorClock: "#bbccbb",
                colorUnclock: "#113344",
                textColorClock: "#113344",
                textColorUnclock: "#bbccbb",
                btnClock: true
            }
        },
        methods: {
            data: {
                btnOnClock: false,
            },
            ClockManager() {
                if (this.btnClock == true) {
                    this.btnClock = false;
                    this.colorClock = "#113344"
                    this.colorUnclock = "#bbccbb"
                    this.textColorClock = "#bbccbb"
                    this.textColorUnclock = "#113344"
                } else {
                    this.btnClock = true;
                    this.colorClock = "#bbccbb"
                    this.colorUnclock = "#113344"
                    this.textColorClock = "#113344"
                    this.textColorUnclock = "#bbccbb"
                }
            }
        }
    }

</script>
