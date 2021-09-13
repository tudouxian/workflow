<!--
 * @Author: your name
 * @Date: 2021-07-15 16:11:07
 * @LastEditTime: 2021-07-20 10:06:41
 * @LastEditors: your name
 * @Description: In User Settings Edit
 * @FilePath: /flow-template-front/src/views/workBench/homePage/index.vue
-->
<template>
  <div class="app-container">
    <el-menu mode="horizontal" @select="onTabClick" :default-active="currentTab">
      <el-submenu index="todo">
        <template slot="title">待办</template>
        <el-menu-item index="PersonalMission">个人任务</el-menu-item>
        <el-menu-item index="GroupMission">组任务</el-menu-item>
      </el-submenu>
      <el-menu-item index="DoneMission">已办</el-menu-item>
      <el-menu-item index="SentMission">已发</el-menu-item>
    </el-menu>
    <transition name="fade-transform" mode="out-in">
      <component :is="currentTab" class="mt20"></component>
    </transition>
  </div>
</template>
<script>
import DoneMission from './DoneMission/DoneMission'
import GroupMission from './GroupMission/GroupMission'
import LaunchMission from './LaunchMission/LaunchMission'
import PersonalMission from './PersonalMission/PersonalMission'
import SentMission from './SentMission/SentMission'
export default {
  components: {
    [DoneMission.name]: DoneMission,
    [GroupMission.name]: GroupMission,
    [LaunchMission.name]: LaunchMission,
    [PersonalMission.name]: PersonalMission,
    [SentMission.name]: SentMission
  },
  data() {
    return {
      currentTab: 'PersonalMission'
    };
  },
  mounted() {},
  methods: {
    onTabClick(index) {
      this.currentTab = index
    }
  }
};
</script>
<style lang="scss" scoped>
</style>
