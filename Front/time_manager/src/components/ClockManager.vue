<template>
  <div style="display: grid; grid-template-rows: 100%; padding: 20px;">
    <b-button v-if="!infoUser.status" @click="setStatus" variant="danger">Not Working</b-button>

    <b-button v-if="infoUser.status" @click="setStatus" variant="success">Working</b-button>
  </div>
</template>
<script>
import Axios from "axios";
import moment from "moment";

export default {
  name: "ClockManager",
  props: {
    infoUser: {
      type: Object
    }
  },
  mounted() {
    this.getClock();
  },
  methods: {
    getClock() {
      this.$http
        .get("http://127.0.0.1:4000/api/clocks/" + localStorage.userId, {
          headers: { Authorization: `Bearer ${localStorage.token}` }
        })
        .then(response => {
          this.infos = JSON.stringify(response.data);
          this.infos = JSON.parse(this.infos);

          if (this.infos.length != 0) this.infoUser.status = true;
          else this.infoUser.status = false;
        })
        .catch(e => console.log(e));
    },
    setStatus() {
      const now = moment(Date.now()).format("YYYY-MM-DD HH:mm:ss");

      Axios.post(
        "http://127.0.0.1:4000/api/clocks/" + this.infoUser.id,
        {
          clock: {
            time: now
          }
        },
        {
          headers: { Authorization: `Bearer ${localStorage.token}` }
        }
      )
        .then(response => {
          this.infos = JSON.stringify(response.data);
          this.infos = JSON.parse(this.infos);          
          if (this.infos.id) this.infoUser.status = true;
          else this.infoUser.status = false;
          localStorage.status = this.infoUser.status;
        })
        .catch(e => console.log(e));
      this.$emit("setStatus");
    }
  }
};
</script>

<style scoped>
.button-work {
  border-radius: 10%;
  height: 30%;
  width: 90%;
  margin: 3%;
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  cursor: pointer;
}

.text {
  white-space: nowrap;
  font-weight: bold;
}
</style>
