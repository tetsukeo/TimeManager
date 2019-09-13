<template>
    <div class="example">
        <h3 class="text">Edit schedules</h3>
        <div style="display: flex; flex-direction: column; padding-left: 25%">
            <div style="padding-bottom: 30px">
                Working Days :
                <datepicker placeholder="Select Date"></datepicker>
            </div>
            <div style="padding-bottom: 30px">
                Start of work :
                <vue-timepicker></vue-timepicker>
            </div>
             <div style="padding-bottom: 30px">
                End of work :
                <vue-timepicker></vue-timepicker>
             </div>
        </div>
    </div>
</template>

<script>
    import Datepicker from 'vuejs-datepicker';
    import VueTimepicker from 'vue2-timepicker'
    import 'vue2-timepicker/dist/VueTimepicker.css'


    import * as lang from "vuejs-datepicker/src/locale";


    const state = {
        date1: new Date()
    };

    export default {
        components : {
            Datepicker,
            VueTimepicker
        },
        name: "WorkingTime",
        data() {
            return {
                format: "d MMMM yyyy",
                disabledDates: {},
                disabledFn: {
                    customPredictor(date) {
                        if (date.getDate() % 3 === 0) {
                            return true;
                        }
                    }
                },
                highlightedFn: {
                    customPredictor(date) {
                        if (date.getDate() % 4 === 0) {
                            return true;
                        }
                    }
                },
                highlighted: {},
                eventMsg: null,
                state: state,
                language: "en",
                languages: lang,
                vModelExample: null,
                changedMonthLog: []
            };
        },
        methods: {}
    }
</script>
