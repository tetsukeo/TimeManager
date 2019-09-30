<template>
  <div class="search">
    <form v-on:submit.prevent="search_user">
      <b-form-input v-model="select" placeholder="Search user"></b-form-input>
    </form>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "SearchBar",
  data() {
    return {
      infos: null,
      sizes: ["Small", "Medium", "Large", "Extra Large"],
      select: null
    };
  },
  mounted() {
    axios
      .get("http://127.0.0.1:4000/api/users", {
        headers: { Authorization: `Bearer ${localStorage.token}` }
      })
      .then(response => {
        this.infos = JSON.stringify(response.data);
        this.infos = JSON.parse(this.infos);
      })
      .catch(e => console.log(e));
  },
  methods: {
    makeToast(variant = null, title, message) {
      this.$bvToast.toast(message, {
        title: `${title || "default"}`,
        variant: variant,
        solid: true
      });
    },
    search_user() {
      let i = 0;
      let find = false;
      while (this.infos[i]) {
        if (
          this.infos[i].email == this.select ||
          this.infos[i].username == this.select ||
          this.infos[i].id == this.select
        ) {
          find = true;
          this.$emit("setUser", this.infos[i]);
        }
        i = i + 1;
      }
      if (find == false) {
        this.makeToast("danger", "Error", "No team");
      }
    }
  }
};
</script>

<style scoped>
.search {
  width: 100%;
  position: relative;
  display: flex;
}

.searchTerm {
  width: 100%;
  border: 3px solid #011936;
  border-right: none;
  padding: 5px;
  height: 20px;
  border-radius: 5px 0 0 5px;
  outline: none;
  color: #9dbfaf;
}

.searchTerm:focus {
  color: #011936;
}

.searchButton {
  width: 40px;
  height: 36px;
  border: 1px solid #011936;
  background: #011936;
  text-align: center;
  color: #fff;
  border-radius: 0 5px 5px 0;
  cursor: pointer;
  font-size: 20px;
}
</style>