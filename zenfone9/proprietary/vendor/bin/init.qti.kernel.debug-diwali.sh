#=============================================================================
# Copyright (c) 2020-2022 Qualcomm Technologies, Inc.
# All Rights Reserved.
# Confidential and Proprietary - Qualcomm Technologies, Inc.
#
# Copyright (c) 2014-2017, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#=============================================================================

enable_tracing_events()
{
    # sound
    echo 1 > /sys/kernel/tracing/events/asoc/snd_soc_reg_read/enable
    echo 1 > /sys/kernel/tracing/events/asoc/snd_soc_reg_write/enable
    # mdp
    echo 1 > /sys/kernel/tracing/events/mdss/mdp_video_underrun_done/enable
    # video
    echo 1 > /sys/kernel/tracing/events/msm_vidc/enable
    # power
    echo 1 > /sys/kernel/tracing/events/msm_low_power/enable
    # fastrpc
    echo 1 > /sys/kernel/tracing/events/fastrpc/enable

    echo 1 > /sys/kernel/tracing/tracing_on
}

# function to enable ftrace events
enable_ftrace_event_tracing()
{
    # bail out if its perf config
    if [ ! -d /sys/module/msm_rtb ]
    then
        return
    fi

    # bail out if ftrace events aren't present
    if [ ! -d /sys/kernel/tracing/events ]
    then
        return
    fi

    enable_tracing_events
}

enable_memory_debug()
{
    # bail out if its perf config
    if [ ! -d /sys/module/msm_rtb ]
    then
        return
    fi

}

# function to enable ftrace event transfer to CoreSight STM
enable_stm_events()
{
    # bail out if its perf config
    if [ ! -d /sys/module/msm_rtb ]
    then
        return
    fi
    # bail out if coresight isn't present
    if [ ! -d /sys/bus/coresight ]
    then
        return
    fi
    # bail out if ftrace events aren't present
    if [ ! -d /sys/kernel/tracing/events ]
    then
        return
    fi

    echo $etr_size > /sys/bus/coresight/devices/coresight-tmc-etr/buffer_size
    echo 1 > /sys/bus/coresight/devices/coresight-tmc-etr/$sinkenable
    echo coresight-stm > /sys/class/stm_source/ftrace/stm_source_link
    echo 1 > /sys/bus/coresight/devices/coresight-stm/$srcenable
    echo 0 > /sys/bus/coresight/devices/coresight-stm/hwevent_enable
}
enable_lpm_with_dcvs_tracing()
{
    # "Configure CPUSS LPM Debug events"
    echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss/reset
    echo 0x0 0x3 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x0 0x3 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x4 0x4 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x4 0x4 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x5 0x5 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x5 0x5 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x6 0x8 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x6 0x8 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0xc 0xf 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0xc 0xf 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0xc 0xf 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x1d 0x1d 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x1d 0x1d 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x2b 0x3f 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x2b 0x3f 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x80 0x9a 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x80 0x9a 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0 0x11111111  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 1 0x66660001  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 2 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 3 0x00100000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 5 0x11111000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 6 0x11111111  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 7 0x11111111  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 16 0x11111111  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 17 0x11111111  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 18 0x11111111  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 19 0x00000111  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 0 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 1 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 2 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 3 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 4 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 5 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 6 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 7 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_ts
    echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_type
    echo 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_trig_ts


    # "Configure CPUCP Trace and Debug Bus ACTPM "
    echo 1 > /sys/bus/coresight/devices/coresight-tpdm-actpm/reset
    ### CMB_MSR : [10]: debug_en, [7:6] : 0x0-0x3 : clkdom0-clkdom3 debug_bus
    ###         : [5]: trace_en, [4]: 0b0:continuous mode 0b1 : legacy mode
    ###         : [3:0] : legacy mode : 0x0 : combined_traces 0x1-0x4 : clkdom0-clkdom3
    ### Select CLKDOM0 (L3) debug bus and all CLKDOM trace bus
    echo 0 0x420 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_msr
    echo 0 > /sys/bus/coresight/devices/coresight-tpdm-actpm/mcmb_lanes_select
    echo 1 0 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_mode
    echo 1 > /sys/bus/coresight/devices/coresight-tpda-actpm/cmbchan_mode
    echo 1 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_ts_all
    echo 1 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_patt_ts
    echo 0 0x20000000 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_patt_mask
    echo 0 0x20000000 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_patt_val

    # "Start Trace collection "
    echo 2 > /sys/bus/coresight/devices/coresight-tpdm-apss/enable_datasets
    echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss/enable_source
    echo 0x4 > /sys/bus/coresight/devices/coresight-tpdm-actpm/enable_datasets
    echo 1 > /sys/bus/coresight/devices/coresight-tpdm-actpm/enable_source

}


enable_stm_hw_events()
{
   #TODO: Add HW events
}

gemnoc_dump()
{
    #; gem_noc_fault_sbm
    echo 0x191b0040 > $DCC_PATH/config
    echo 0x191b0048 > $DCC_PATH/config
    #; gem_noc_qns_cnoc_poc_err
    echo 0x19180010 > $DCC_PATH/config
    echo 0x19180020 6 > $DCC_PATH/config
    #; gem_noc_qns_pcie_poc_err
    echo 0x19181010 > $DCC_PATH/config
    echo 0x19181020 6 > $DCC_PATH/config
    #; gem_noc_qns_llcc0_poc_err
    echo 0x19100010 > $DCC_PATH/config
    echo 0x19100020 6 > $DCC_PATH/config
    #; gem_noc_qns_llcc1_poc_err
    echo 0x19140010 > $DCC_PATH/config
    echo 0x19140020 6 > $DCC_PATH/config
    #; gem_noc_qns_llcc2_poc_err
    #; gem_noc_qns_llcc3_poc_err

    #; gem_noc_qns_cnoc_poc_dbg
    echo 0x19180410 > $DCC_PATH/config
    echo 0x10  > $DCC_PATH/loop
    echo 0x19180438 > $DCC_PATH/config
    echo 0x19180430 2 > $DCC_PATH/config
    echo 0x19180430 2 > $DCC_PATH/config
    echo 0x19180430 2 > $DCC_PATH/config
    echo 0x19180430 2 > $DCC_PATH/config
    echo 0x1  > $DCC_PATH/loop
    echo 0x19180408 2 > $DCC_PATH/config
    #; gem_noc_qns_pcie_poc_dbg
    echo 0x19181410 > $DCC_PATH/config
    echo 0x10  > $DCC_PATH/loop
    echo 0x19181438 > $DCC_PATH/config
    echo 0x19181430 2 > $DCC_PATH/config
    echo 0x19181430 2 > $DCC_PATH/config
    echo 0x19181430 2 > $DCC_PATH/config
    echo 0x19181430 2 > $DCC_PATH/config
    echo 0x1  > $DCC_PATH/loop
    echo 0x19181408 2 > $DCC_PATH/config
    #; gem_noc_qns_llcc0_poc_dbg
    echo 0x19100410 > $DCC_PATH/config
    echo 0x40  > $DCC_PATH/loop
    echo 0x19100438 > $DCC_PATH/config
    echo 0x19100430 2 > $DCC_PATH/config
    echo 0x19100430 2 > $DCC_PATH/config
    echo 0x19100430 2 > $DCC_PATH/config
    echo 0x19100430 2 > $DCC_PATH/config
    echo 0x1  > $DCC_PATH/loop
    echo 0x19100408 2 > $DCC_PATH/config
    #; gem_noc_qns_llcc1_poc_dbg
    echo 0x19140410 > $DCC_PATH/config
    echo 0x40  > $DCC_PATH/loop
    echo 0x19140438 > $DCC_PATH/config
    echo 0x19140430 2 > $DCC_PATH/config
    echo 0x19140430 2 > $DCC_PATH/config
    echo 0x19140430 2 > $DCC_PATH/config
    echo 0x19140430 2 > $DCC_PATH/config
    echo 0x1  > $DCC_PATH/loop
    echo 0x19140408 2 > $DCC_PATH/config

    #; NonCoherent_sys_chain
    echo 0x19191018 > $DCC_PATH/config
    echo 0x19191008 > $DCC_PATH/config
    echo 0x19191010 2 > $DCC_PATH/config
    echo 0x19191010 2 > $DCC_PATH/config
    echo 0x19191010 2 > $DCC_PATH/config
    echo 0x19191010 2 > $DCC_PATH/config
    echo 0x19191010 2 > $DCC_PATH/config
    echo 0x19191010 2 > $DCC_PATH/config
    echo 0x19191010 2 > $DCC_PATH/config
    echo 0x19191010 2 > $DCC_PATH/config
    echo 0x19191010 2 > $DCC_PATH/config
    #; NonCoherent_odd_chain
    echo 0x1914d018 > $DCC_PATH/config
    echo 0x1914d008 > $DCC_PATH/config
    echo 0x1914d010 2 > $DCC_PATH/config
    echo 0x1914d010 2 > $DCC_PATH/config
    echo 0x1914d010 2 > $DCC_PATH/config
    echo 0x1914d010 2 > $DCC_PATH/config
    echo 0x1914d010 2 > $DCC_PATH/config
    #; NonCoherent_even_chain
    echo 0x1910d018 > $DCC_PATH/config
    echo 0x1910d008 > $DCC_PATH/config
    echo 0x1910d010 2 > $DCC_PATH/config
    echo 0x1910d010 2 > $DCC_PATH/config
    echo 0x1910d010 2 > $DCC_PATH/config
    echo 0x1910d010 2 > $DCC_PATH/config
    echo 0x1910d010 2 > $DCC_PATH/config
    #; Coherent_sys_chain
    echo 0x19190018 > $DCC_PATH/config
    echo 0x19190008 > $DCC_PATH/config
    echo 0x19190010 2 > $DCC_PATH/config
    echo 0x19190010 2 > $DCC_PATH/config
    echo 0x19190010 2 > $DCC_PATH/config
    #; Coherent_odd_chain
    echo 0x1914c018 > $DCC_PATH/config
    echo 0x1914c008 > $DCC_PATH/config
    echo 0x1914c010 2 > $DCC_PATH/config
    echo 0x1914c010 2 > $DCC_PATH/config
    echo 0x1914c010 2 > $DCC_PATH/config
    echo 0x1914c010 2 > $DCC_PATH/config
    #; Coherent_even_chain
    echo 0x1910c018 > $DCC_PATH/config
    echo 0x1910c008 > $DCC_PATH/config
    echo 0x1910c010 2 > $DCC_PATH/config
    echo 0x1910c010 2 > $DCC_PATH/config
    echo 0x1910c010 2 > $DCC_PATH/config
    echo 0x1910c010 2 > $DCC_PATH/config

    echo 0x19121010 > $DCC_PATH/config
    echo 0x19123010 > $DCC_PATH/config
    echo 0x191a1010 > $DCC_PATH/config
    echo 0x191a4010 > $DCC_PATH/config
    echo 0x191a5010 > $DCC_PATH/config
    echo 0x191a0010 > $DCC_PATH/config
    echo 0x19160010 > $DCC_PATH/config
    echo 0x19120010 > $DCC_PATH/config
    echo 0x191a6010 > $DCC_PATH/config
    echo 0x19122010 > $DCC_PATH/config
    echo 0x191a2010 > $DCC_PATH/config
    echo 0x191a3010 > $DCC_PATH/config
    echo 0x19161010 > $DCC_PATH/config
    echo 0x19162010 > $DCC_PATH/config
    echo 0x19163010 > $DCC_PATH/config
}

dc_noc_dump() {
    #; dc_noc_dch_erl
    echo 0x190e0010 > $DCC_PATH/config
    echo 0x190e0020 8 > $DCC_PATH/config
    echo 0x190e0248 > $DCC_PATH/config
    #; dc_noc_ch_hm02_erl
    #; dc_noc_ch_hm13_erl

    #; dch/DebugChain
    echo 0x190e5018 > $DCC_PATH/config
    echo 0x190e5008 > $DCC_PATH/config
    echo 0x6  > $DCC_PATH/loop
    echo 0x190e5010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
}

lpass_ag_noc_dump() {
    #; lpass_ag_noc_lpass_ag_noc_Errorlogger_erl
    echo 0x3c40010 > $DCC_PATH/config
    echo 0x3c40020 8 > $DCC_PATH/config
    echo 0x3c4b048 > $DCC_PATH/config

    #; agnoc_core_DebugChain
    echo 0x3c41018 > $DCC_PATH/config
    echo 0x3c41008 > $DCC_PATH/config
    echo 0x5  > $DCC_PATH/loop
    echo 0x3c41010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
}

mmss_noc_dump() {
    echo 0x175B010 > $DCC_PATH/config
    echo 0x175B090 > $DCC_PATH/config
    echo 0x175B110 > $DCC_PATH/config
    echo 0x174B090 > $DCC_PATH/config
    echo 0x174B010 > $DCC_PATH/config
    echo 0x174C010 > $DCC_PATH/config
    echo 0x175D010 > $DCC_PATH/config
    echo 0x174C090 > $DCC_PATH/config
    echo 0x175C010 > $DCC_PATH/config
    echo 0x175C090 > $DCC_PATH/config
}

system_noc_dump() {
    #; system_noc_erl
    echo 0x1680010 > $DCC_PATH/config
    echo 0x1680020 8 > $DCC_PATH/config
    echo 0x1680248 > $DCC_PATH/config

    #; DebugChain
    echo 0x1681018 > $DCC_PATH/config
    echo 0x1681008 > $DCC_PATH/config
    echo 0x7  > $DCC_PATH/loop
    echo 0x1681010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop

    echo 0x1691010 > $DCC_PATH/config
    echo 0x1697010 > $DCC_PATH/config
    echo 0x1698010 > $DCC_PATH/config
    echo 0x1694010 > $DCC_PATH/config
    echo 0x1696010 > $DCC_PATH/config
    echo 0x1699010 > $DCC_PATH/config
}

aggre_noc_dump() {
    #; aggre_noc_a1noc_ErrorLogger_erl
    echo 0x16e0010 > $DCC_PATH/config
    echo 0x16e0020 8 > $DCC_PATH/config
    echo 0x16e0248 > $DCC_PATH/config
    #; aggre_noc_a2noc_ErrorLogger_erl
    echo 0x1700010 > $DCC_PATH/config
    echo 0x1700020 8 > $DCC_PATH/config
    echo 0x1700248 > $DCC_PATH/config
    #; aggre_noc_pcie_anoc_ErrorLogger_erl
    echo 0x16c0010 > $DCC_PATH/config
    echo 0x16c0020 8 > $DCC_PATH/config
    echo 0x16c0248 > $DCC_PATH/config

    #; aggre_noc/DebugChain_south
    echo 0x16e1018 > $DCC_PATH/config
    echo 0x16e1008 > $DCC_PATH/config
    echo 0x4  > $DCC_PATH/loop
    echo 0x16e1010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    #; aggre_noc/DebugChain_pcie
    echo 0x16c1018 > $DCC_PATH/config
    echo 0x16c1008 > $DCC_PATH/config
    echo 0x4  > $DCC_PATH/loop
    echo 0x16c1010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    #; aggre_noc/DebugChain_center
    echo 0x1701018 > $DCC_PATH/config
    echo 0x1701008 > $DCC_PATH/config
    echo 0x5  > $DCC_PATH/loop
    echo 0x1701010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop

    echo 0x16e9010 > $DCC_PATH/config
    echo 0x16ea010 > $DCC_PATH/config
    echo 0x16eb010 > $DCC_PATH/config
    echo 0x1710010 > $DCC_PATH/config
    echo 0x1714010 > $DCC_PATH/config
    echo 0x1711010 > $DCC_PATH/config
    echo 0x170e010 > $DCC_PATH/config
    echo 0x170f010 > $DCC_PATH/config
    echo 0x1712010 > $DCC_PATH/config
    echo 0x1713010 > $DCC_PATH/config
    echo 0x1715010 > $DCC_PATH/config
}

config_noc_dump() {
    #; config_noc_erl
    echo 0x1500010 > $DCC_PATH/config
    echo 0x1500020 8 > $DCC_PATH/config
    echo 0x1500248 2 > $DCC_PATH/config
    echo 0x1500258 > $DCC_PATH/config
    echo 0x1500448 > $DCC_PATH/config

    #; config_noc/south_DebugChain
    echo 0x1512018 > $DCC_PATH/config
    echo 0x1512008 > $DCC_PATH/config
    echo 0x3  > $DCC_PATH/loop
    echo 0x1512010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    #; config_noc/north_DebugChain
    echo 0x1513018 > $DCC_PATH/config
    echo 0x1513008 > $DCC_PATH/config
    echo 0x4  > $DCC_PATH/loop
    echo 0x1513010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    #; config_noc/center_DebugChain
    echo 0x1510018 > $DCC_PATH/config
    echo 0x1510008 > $DCC_PATH/config
    echo 0xb  > $DCC_PATH/loop
    echo 0x1510010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x1847ac > $DCC_PATH/config
}


config_dcc_ddr()
{
    #DDR -DCC starts here.
    #Start Link list #6
    #DDRSS
    echo 0x19080024 > $DCC_PATH/config
    echo 0x1908002c > $DCC_PATH/config
    echo 0x19080034 > $DCC_PATH/config
    echo 0x1908003c > $DCC_PATH/config
    echo 0x19080044 > $DCC_PATH/config
    echo 0x1908004c > $DCC_PATH/config
    echo 0x19080058 2 > $DCC_PATH/config
    echo 0x190800c8 > $DCC_PATH/config
    echo 0x190800d4 > $DCC_PATH/config
    echo 0x190800e0 > $DCC_PATH/config
    echo 0x19080144 > $DCC_PATH/config
    echo 0x1908014c > $DCC_PATH/config
    echo 0x19080174 > $DCC_PATH/config
    echo 0x1908017c > $DCC_PATH/config
    echo 0x19080184 > $DCC_PATH/config
    echo 0x1908018c > $DCC_PATH/config
    echo 0x19080194 > $DCC_PATH/config
    echo 0x1908019c > $DCC_PATH/config
    echo 0x190801a4 > $DCC_PATH/config
    echo 0x190801ac 3 > $DCC_PATH/config

    #DPCC
    echo 0x190a9168 2 > $DCC_PATH/config
    echo 0x190a9178 2 > $DCC_PATH/config
    echo 0x190a9188 2 > $DCC_PATH/config
    echo 0x190a80e4 2 > $DCC_PATH/config
    echo 0x190a80f8 5 > $DCC_PATH/config
    echo 0x190a8150 2 > $DCC_PATH/config
    echo 0x190a8164 2 > $DCC_PATH/config
    echo 0x190a8174 4 > $DCC_PATH/config
    echo 0x190a819c > $DCC_PATH/config
    echo 0x190a81cc > $DCC_PATH/config
    echo 0x190a8498 > $DCC_PATH/config
    echo 0x190a8804 > $DCC_PATH/config
    echo 0x190a880c > $DCC_PATH/config
    echo 0x190a8834 > $DCC_PATH/config
    echo 0x190a8840 2 > $DCC_PATH/config
    echo 0x190a8850 2 > $DCC_PATH/config
    echo 0x190a8860 3 > $DCC_PATH/config
    echo 0x190a8878 > $DCC_PATH/config
    echo 0x190a888c > $DCC_PATH/config
    echo 0x190a8900 > $DCC_PATH/config
    echo 0x190a9134 2 > $DCC_PATH/config
    echo 0x190a9198 2 > $DCC_PATH/config
    echo 0x190a91c4 2 > $DCC_PATH/config
    echo 0x190aa034 3 > $DCC_PATH/config
    echo 0x190aa044 > $DCC_PATH/config
    echo 0x190aa04c > $DCC_PATH/config
    echo 0x190a8884 > $DCC_PATH/config
    echo 0x190a9140 > $DCC_PATH/config

    #DPCC_PLL
    echo 0x190a0008 2 > $DCC_PATH/config
    echo 0x190a1008 2 > $DCC_PATH/config

    # LLCC
    echo 0x19220344 9 > $DCC_PATH/config
    echo 0x19220370 7 > $DCC_PATH/config
    echo 0x19220480 > $DCC_PATH/config
    echo 0x19222400 26 > $DCC_PATH/config
    echo 0x19222470 5 > $DCC_PATH/config
    echo 0x1922320c > $DCC_PATH/config
    echo 0x19223214 2 > $DCC_PATH/config
    echo 0x19223220 4 > $DCC_PATH/config
    echo 0x19223308 > $DCC_PATH/config
    echo 0x19223318 > $DCC_PATH/config
    echo 0x19223318 > $DCC_PATH/config
    echo 0x1922358c > $DCC_PATH/config
    echo 0x19234010 > $DCC_PATH/config
    echo 0x1923801c 8 > $DCC_PATH/config
    echo 0x19238050 > $DCC_PATH/config
    echo 0x19238100 > $DCC_PATH/config
    echo 0x19238100 7 > $DCC_PATH/config
    echo 0x1923c004 > $DCC_PATH/config
    echo 0x1923c014 > $DCC_PATH/config
    echo 0x1923c020 > $DCC_PATH/config
    echo 0x1923c030 > $DCC_PATH/config
    echo 0x1923c05c 3 > $DCC_PATH/config
    echo 0x1923c074 > $DCC_PATH/config
    echo 0x1923c088 > $DCC_PATH/config
    echo 0x1923c0a0 > $DCC_PATH/config
    echo 0x1923c0b0 > $DCC_PATH/config
    echo 0x1923c0c0 > $DCC_PATH/config
    echo 0x1923c0d0 > $DCC_PATH/config
    echo 0x1923c0e0 > $DCC_PATH/config
    echo 0x1923c0f0 > $DCC_PATH/config
    echo 0x1923c100 > $DCC_PATH/config
    echo 0x1923d064 > $DCC_PATH/config
    echo 0x19240008 6 > $DCC_PATH/config
    echo 0x19240028 > $DCC_PATH/config
    echo 0x1924203c 3 > $DCC_PATH/config
    echo 0x19242044 2 > $DCC_PATH/config
    echo 0x19242048 2 > $DCC_PATH/config
    echo 0x1924204c 10 > $DCC_PATH/config
    echo 0x1924208c > $DCC_PATH/config
    echo 0x192420b0 > $DCC_PATH/config
    echo 0x192420b0 > $DCC_PATH/config
    echo 0x192420b8 3 > $DCC_PATH/config
    echo 0x192420f4 > $DCC_PATH/config
    echo 0x192420fc 3 > $DCC_PATH/config
    echo 0x19242104 5 > $DCC_PATH/config
    echo 0x19242114 > $DCC_PATH/config
    echo 0x19242324 14 > $DCC_PATH/config
    echo 0x19242410 > $DCC_PATH/config
    echo 0x192430a8 > $DCC_PATH/config
    echo 0x19248004 7 > $DCC_PATH/config
    echo 0x19248024 > $DCC_PATH/config
    echo 0x19248040 > $DCC_PATH/config
    echo 0x19248048 > $DCC_PATH/config
    echo 0x19249064 > $DCC_PATH/config
    echo 0x1924c000 > $DCC_PATH/config
    echo 0x1924c030 > $DCC_PATH/config
    echo 0x1924c030 3 > $DCC_PATH/config
    echo 0x1924c040 3 > $DCC_PATH/config
    echo 0x1924c054 2 > $DCC_PATH/config
    echo 0x1924c078 > $DCC_PATH/config
    echo 0x1924c108 > $DCC_PATH/config
    echo 0x1924c110 > $DCC_PATH/config
    echo 0x19250020 > $DCC_PATH/config
    echo 0x19250020 > $DCC_PATH/config
    echo 0x19251054 > $DCC_PATH/config
    echo 0x19252014 3 > $DCC_PATH/config
    echo 0x19252028 > $DCC_PATH/config
    echo 0x19252028 17 > $DCC_PATH/config
    echo 0x19252070 8 > $DCC_PATH/config
    echo 0x19252098 > $DCC_PATH/config
    echo 0x192520a0 > $DCC_PATH/config
    echo 0x192520b4 > $DCC_PATH/config
    echo 0x192520c0 > $DCC_PATH/config
    echo 0x192520d0 3 > $DCC_PATH/config
    echo 0x192520f4 10 > $DCC_PATH/config
    echo 0x19252120 12 > $DCC_PATH/config
    echo 0x1925802c > $DCC_PATH/config
    echo 0x1925809c 2 > $DCC_PATH/config
    echo 0x192580a8 3 > $DCC_PATH/config
    echo 0x192580b8 > $DCC_PATH/config
    echo 0x192580c0 7 > $DCC_PATH/config
    echo 0x192580e0 > $DCC_PATH/config
    echo 0x192580e8 > $DCC_PATH/config
    echo 0x192580f0 > $DCC_PATH/config
    echo 0x192580f8 > $DCC_PATH/config
    echo 0x19258100 > $DCC_PATH/config
    echo 0x19258108 > $DCC_PATH/config
    echo 0x19258110 > $DCC_PATH/config
    echo 0x19258118 > $DCC_PATH/config
    echo 0x19258120 > $DCC_PATH/config
    echo 0x19258128 > $DCC_PATH/config
    echo 0x19258210 3 > $DCC_PATH/config
    echo 0x19259010 > $DCC_PATH/config
    echo 0x19259070 > $DCC_PATH/config
    echo 0x1925b004 > $DCC_PATH/config
    echo 0x1926004c > $DCC_PATH/config
    echo 0x1926004c 2 > $DCC_PATH/config
    echo 0x19260050 2 > $DCC_PATH/config
    echo 0x19260054 2 > $DCC_PATH/config
    echo 0x19260058 2 > $DCC_PATH/config
    echo 0x1926005c 2 > $DCC_PATH/config
    echo 0x19260060 2 > $DCC_PATH/config
    echo 0x19260064 2 > $DCC_PATH/config
    echo 0x19260068 3 > $DCC_PATH/config
    echo 0x19260078 > $DCC_PATH/config
    echo 0x1926020c > $DCC_PATH/config
    echo 0x19260214 > $DCC_PATH/config
    echo 0x19261084 > $DCC_PATH/config
    echo 0x19262020 > $DCC_PATH/config
    echo 0x19263020 > $DCC_PATH/config
    echo 0x19264020 > $DCC_PATH/config
    echo 0x19265020 > $DCC_PATH/config
    echo 0x19320344 2 > $DCC_PATH/config
    echo 0x19320348 8 > $DCC_PATH/config
    echo 0x19320370 7 > $DCC_PATH/config
    echo 0x19320480 > $DCC_PATH/config
    echo 0x19320480 > $DCC_PATH/config
    echo 0x19322400 > $DCC_PATH/config
    echo 0x19322400 26 > $DCC_PATH/config
    echo 0x19322470 5 > $DCC_PATH/config
    echo 0x1932320c > $DCC_PATH/config
    echo 0x19323214 2 > $DCC_PATH/config
    echo 0x19323220 > $DCC_PATH/config
    echo 0x19323220 2 > $DCC_PATH/config
    echo 0x19323224 2 > $DCC_PATH/config
    echo 0x19323228 2 > $DCC_PATH/config
    echo 0x1932322c > $DCC_PATH/config
    echo 0x19323308 > $DCC_PATH/config
    echo 0x19323308 > $DCC_PATH/config
    echo 0x19323318 > $DCC_PATH/config
    echo 0x19323318 > $DCC_PATH/config
    echo 0x1932358c > $DCC_PATH/config
    echo 0x19334010 > $DCC_PATH/config
    echo 0x1933801c 8 > $DCC_PATH/config
    echo 0x19338050 > $DCC_PATH/config
    echo 0x19338100 > $DCC_PATH/config
    echo 0x19338100 7 > $DCC_PATH/config
    echo 0x1933c004 > $DCC_PATH/config
    echo 0x1933c014 > $DCC_PATH/config
    echo 0x1933c020 > $DCC_PATH/config
    echo 0x1933c030 > $DCC_PATH/config
    echo 0x1933c05c 3 > $DCC_PATH/config
    echo 0x1933c074 > $DCC_PATH/config
    echo 0x1933c088 > $DCC_PATH/config
    echo 0x1933c0a0 > $DCC_PATH/config
    echo 0x1933c0b0 > $DCC_PATH/config
    echo 0x1933c0c0 > $DCC_PATH/config
    echo 0x1933c0d0 > $DCC_PATH/config
    echo 0x1933c0e0 > $DCC_PATH/config
    echo 0x1933c0f0 > $DCC_PATH/config
    echo 0x1933c100 > $DCC_PATH/config
    echo 0x1933d064 > $DCC_PATH/config
    echo 0x19340008 6 > $DCC_PATH/config
    echo 0x19340028 > $DCC_PATH/config
    echo 0x1934203c 3 > $DCC_PATH/config
    echo 0x19342044 2 > $DCC_PATH/config
    echo 0x19342048 2 > $DCC_PATH/config
    echo 0x1934204c 10 > $DCC_PATH/config
    echo 0x1934208c > $DCC_PATH/config
    echo 0x193420b0 > $DCC_PATH/config
    echo 0x193420b0 > $DCC_PATH/config
    echo 0x193420b8 3 > $DCC_PATH/config
    echo 0x193420f4 > $DCC_PATH/config
    echo 0x193420fc 3 > $DCC_PATH/config
    echo 0x19342104 5 > $DCC_PATH/config
    echo 0x19342114 > $DCC_PATH/config
    echo 0x19342324 14 > $DCC_PATH/config
    echo 0x19342410 > $DCC_PATH/config
    echo 0x193430a8 > $DCC_PATH/config
    echo 0x19348004 > $DCC_PATH/config
    echo 0x19348004 2 > $DCC_PATH/config
    echo 0x19348008 2 > $DCC_PATH/config
    echo 0x1934800c 2 > $DCC_PATH/config
    echo 0x19348010 4 > $DCC_PATH/config
    echo 0x19348024 > $DCC_PATH/config
    echo 0x19348040 > $DCC_PATH/config
    echo 0x19348048 > $DCC_PATH/config
    echo 0x19349064 > $DCC_PATH/config
    echo 0x1934c000 > $DCC_PATH/config
    echo 0x1934c030 > $DCC_PATH/config
    echo 0x1934c030 3 > $DCC_PATH/config
    echo 0x1934c040 3 > $DCC_PATH/config
    echo 0x1934c054 2 > $DCC_PATH/config
    echo 0x1934c078 > $DCC_PATH/config
    echo 0x1934c108 > $DCC_PATH/config
    echo 0x1934c110 > $DCC_PATH/config
    echo 0x19350020 > $DCC_PATH/config
    echo 0x19350020 > $DCC_PATH/config
    echo 0x19351054 > $DCC_PATH/config
    echo 0x19352014 3 > $DCC_PATH/config
    echo 0x19352028 > $DCC_PATH/config
    echo 0x19352028 17 > $DCC_PATH/config
    echo 0x19352070 8 > $DCC_PATH/config
    echo 0x19352098 > $DCC_PATH/config
    echo 0x193520a0 > $DCC_PATH/config
    echo 0x193520b4 > $DCC_PATH/config
    echo 0x193520c0 > $DCC_PATH/config
    echo 0x193520d0 3 > $DCC_PATH/config
    echo 0x193520f4 10 > $DCC_PATH/config
    echo 0x19352120 12 > $DCC_PATH/config
    echo 0x1935802c > $DCC_PATH/config
    echo 0x1935802c > $DCC_PATH/config
    echo 0x1935809c > $DCC_PATH/config
    echo 0x1935809c 2 > $DCC_PATH/config
    echo 0x193580a8 3 > $DCC_PATH/config
    echo 0x193580b8 > $DCC_PATH/config
    echo 0x193580c0 7 > $DCC_PATH/config
    echo 0x193580e0 > $DCC_PATH/config
    echo 0x193580e8 > $DCC_PATH/config
    echo 0x193580f0 > $DCC_PATH/config
    echo 0x193580f8 > $DCC_PATH/config
    echo 0x193580a0 > $DCC_PATH/config
    echo 0x193580a8 3 > $DCC_PATH/config
    echo 0x193580b8 > $DCC_PATH/config
    echo 0x193580c0 7 > $DCC_PATH/config
    echo 0x193580e0 > $DCC_PATH/config
    echo 0x193580e8 > $DCC_PATH/config
    echo 0x193580f0 > $DCC_PATH/config
    echo 0x193580f8 > $DCC_PATH/config
    echo 0x19358100 > $DCC_PATH/config
    echo 0x19358100 > $DCC_PATH/config
    echo 0x19358108 > $DCC_PATH/config
    echo 0x19358108 > $DCC_PATH/config
    echo 0x19358110 > $DCC_PATH/config
    echo 0x19358110 > $DCC_PATH/config
    echo 0x19358118 > $DCC_PATH/config
    echo 0x19358118 > $DCC_PATH/config
    echo 0x19358120 > $DCC_PATH/config
    echo 0x19358120 > $DCC_PATH/config
    echo 0x19358128 > $DCC_PATH/config
    echo 0x19358128 > $DCC_PATH/config
    echo 0x19358210 > $DCC_PATH/config
    echo 0x19358210 2 > $DCC_PATH/config
    echo 0x19358214 2 > $DCC_PATH/config
    echo 0x19358218 > $DCC_PATH/config
    echo 0x19359010 > $DCC_PATH/config
    echo 0x19359010 > $DCC_PATH/config
    echo 0x19359070 > $DCC_PATH/config
    echo 0x19359070 > $DCC_PATH/config
    echo 0x1935b004 > $DCC_PATH/config
    echo 0x1935b004 > $DCC_PATH/config
    echo 0x1936004c > $DCC_PATH/config
    echo 0x1936004c > $DCC_PATH/config
    echo 0x1936004c 2 > $DCC_PATH/config
    echo 0x19360050 > $DCC_PATH/config
    echo 0x19360050 2 > $DCC_PATH/config
    echo 0x19360054 > $DCC_PATH/config
    echo 0x19360054 2 > $DCC_PATH/config
    echo 0x19360058 > $DCC_PATH/config
    echo 0x19360058 2 > $DCC_PATH/config
    echo 0x1936005c > $DCC_PATH/config
    echo 0x1936005c 2 > $DCC_PATH/config
    echo 0x19360060 > $DCC_PATH/config
    echo 0x19360060 2 > $DCC_PATH/config
    echo 0x19360064 > $DCC_PATH/config
    echo 0x19360064 2 > $DCC_PATH/config
    echo 0x19360068 > $DCC_PATH/config
    echo 0x19360068 3 > $DCC_PATH/config
    echo 0x19360078 > $DCC_PATH/config
    echo 0x1936020c > $DCC_PATH/config
    echo 0x19360214 > $DCC_PATH/config
    echo 0x19361084 > $DCC_PATH/config
    echo 0x19362020 > $DCC_PATH/config
    echo 0x19363020 > $DCC_PATH/config
    echo 0x19364020 > $DCC_PATH/config
    echo 0x19365020 > $DCC_PATH/config
    echo 0x19200004 > $DCC_PATH/config
    echo 0x19201004 > $DCC_PATH/config
    echo 0x19202004 > $DCC_PATH/config
    echo 0x19203004 > $DCC_PATH/config
    echo 0x19204004 > $DCC_PATH/config
    echo 0x19205004 > $DCC_PATH/config
    echo 0x19206004 > $DCC_PATH/config
    echo 0x19207004 > $DCC_PATH/config
    echo 0x19208004 > $DCC_PATH/config
    echo 0x19209004 > $DCC_PATH/config
    echo 0x1920a004 > $DCC_PATH/config
    echo 0x1920b004 > $DCC_PATH/config
    echo 0x1920c004 > $DCC_PATH/config
    echo 0x1920d004 > $DCC_PATH/config
    echo 0x1920e004 > $DCC_PATH/config
    echo 0x1920f004 > $DCC_PATH/config
    echo 0x19210004 > $DCC_PATH/config
    echo 0x19211004 > $DCC_PATH/config
    echo 0x19212004 > $DCC_PATH/config
    echo 0x19213004 > $DCC_PATH/config
    echo 0x19214004 > $DCC_PATH/config
    echo 0x19215004 > $DCC_PATH/config
    echo 0x19216004 > $DCC_PATH/config
    echo 0x19217004 > $DCC_PATH/config
    echo 0x19218004 > $DCC_PATH/config
    echo 0x19219004 > $DCC_PATH/config
    echo 0x1921a004 > $DCC_PATH/config
    echo 0x1921b004 > $DCC_PATH/config
    echo 0x1921c004 > $DCC_PATH/config
    echo 0x1921d004 > $DCC_PATH/config
    echo 0x1921e004 > $DCC_PATH/config
    echo 0x1921f004 > $DCC_PATH/config


    # MC5
    echo 0x192c5cac 3 > $DCC_PATH/config
    echo 0x192c0080 > $DCC_PATH/config
    echo 0x192c0310 > $DCC_PATH/config
    echo 0x192c0400 2 > $DCC_PATH/config
    echo 0x192c0410 6 > $DCC_PATH/config
    echo 0x192c0430 > $DCC_PATH/config
    echo 0x192c0440 > $DCC_PATH/config
    echo 0x192c0448 > $DCC_PATH/config
    echo 0x192c04a0 > $DCC_PATH/config
    echo 0x192c04b0 4 > $DCC_PATH/config
    echo 0x192c04d0 2 > $DCC_PATH/config
    echo 0x192c1400 > $DCC_PATH/config
    echo 0x192c1408 > $DCC_PATH/config
    echo 0x192c2400 2 > $DCC_PATH/config
    echo 0x192c2438 2 > $DCC_PATH/config
    echo 0x192c2454 > $DCC_PATH/config
    echo 0x192c3400 4 > $DCC_PATH/config
    echo 0x192c3418 3 > $DCC_PATH/config
    echo 0x192c4700 > $DCC_PATH/config
    echo 0x192c53b0 > $DCC_PATH/config
    echo 0x192c5804 > $DCC_PATH/config
    echo 0x192c590c > $DCC_PATH/config
    echo 0x192c5a14 > $DCC_PATH/config
    echo 0x192c5c0c > $DCC_PATH/config
    echo 0x192c5c18 2 > $DCC_PATH/config
    echo 0x192c5c2c 2 > $DCC_PATH/config
    echo 0x192c5c38 > $DCC_PATH/config
    echo 0x192c5c4c > $DCC_PATH/config
    echo 0x192c5ca4 > $DCC_PATH/config
    echo 0x192c5cac 3 > $DCC_PATH/config
    echo 0x192c6400 > $DCC_PATH/config
    echo 0x192c6418 2 > $DCC_PATH/config
    echo 0x192c9100 > $DCC_PATH/config
    echo 0x192c9110 > $DCC_PATH/config
    echo 0x192c9120 > $DCC_PATH/config
    echo 0x192c9180 > $DCC_PATH/config
    echo 0x192c9180 2 > $DCC_PATH/config
    echo 0x192c9184 > $DCC_PATH/config
    echo 0x192c91a0 > $DCC_PATH/config
    echo 0x192c91b0 > $DCC_PATH/config
    echo 0x192c91c0 2 > $DCC_PATH/config
    echo 0x192c91e0 > $DCC_PATH/config
    echo 0x193c5cac 3 > $DCC_PATH/config
    echo 0x193c0080 > $DCC_PATH/config
    echo 0x193c0310 > $DCC_PATH/config
    echo 0x193c0400 2 > $DCC_PATH/config
    echo 0x193c0410 6 > $DCC_PATH/config
    echo 0x193c0430 > $DCC_PATH/config
    echo 0x193c0440 > $DCC_PATH/config
    echo 0x193c0448 > $DCC_PATH/config
    echo 0x193c04a0 > $DCC_PATH/config
    echo 0x193c04b0 4 > $DCC_PATH/config
    echo 0x193c04d0 2 > $DCC_PATH/config
    echo 0x193c1400 > $DCC_PATH/config
    echo 0x193c1408 > $DCC_PATH/config
    echo 0x193c2400 2 > $DCC_PATH/config
    echo 0x193c2438 2 > $DCC_PATH/config
    echo 0x193c2454 > $DCC_PATH/config
    echo 0x193c3400 4 > $DCC_PATH/config
    echo 0x193c3418 3 > $DCC_PATH/config
    echo 0x193c4700 > $DCC_PATH/config
    echo 0x193c53b0 > $DCC_PATH/config
    echo 0x193c5804 > $DCC_PATH/config
    echo 0x193c590c > $DCC_PATH/config
    echo 0x193c5a14 > $DCC_PATH/config
    echo 0x193c5c0c > $DCC_PATH/config
    echo 0x193c5c18 2 > $DCC_PATH/config
    echo 0x193c5c2c 2 > $DCC_PATH/config
    echo 0x193c5c38 > $DCC_PATH/config
    echo 0x193c5c4c > $DCC_PATH/config
    echo 0x193c5ca4 > $DCC_PATH/config
    echo 0x193c5cac 3 > $DCC_PATH/config
    echo 0x193c6400 > $DCC_PATH/config
    echo 0x193c6418 2 > $DCC_PATH/config
    echo 0x193c9100 > $DCC_PATH/config
    echo 0x193c9110 > $DCC_PATH/config
    echo 0x193c9120 > $DCC_PATH/config
    echo 0x193c9180 > $DCC_PATH/config
    echo 0x193c9180 2 > $DCC_PATH/config
    echo 0x193c9184 > $DCC_PATH/config
    echo 0x193c91a0 > $DCC_PATH/config
    echo 0x193c91b0 > $DCC_PATH/config
    echo 0x193c91c0 2 > $DCC_PATH/config
    echo 0x193c91e0 > $DCC_PATH/config
    echo 0x192c1420 > $DCC_PATH/config
    echo 0x192c1430 > $DCC_PATH/config
    echo 0x193c1420 > $DCC_PATH/config
    echo 0x193c1430 > $DCC_PATH/config


    # MCCC
    echo 0x190ba280 > $DCC_PATH/config
    echo 0x190ba288 8 > $DCC_PATH/config
    echo 0x192e0610 4 > $DCC_PATH/config
    echo 0x192e0680 4 > $DCC_PATH/config
    echo 0x193e0610 3 > $DCC_PATH/config
    echo 0x193e0618 2 > $DCC_PATH/config
    echo 0x193e0680 2 > $DCC_PATH/config
    echo 0x193e0684 3 > $DCC_PATH/config
    echo 0x193e068c > $DCC_PATH/config

    # DDRPHY
    echo 0x19281e64 > $DCC_PATH/config
    echo 0x19281ea0 > $DCC_PATH/config
    echo 0x19281f30 2 > $DCC_PATH/config
    echo 0x19283e64 > $DCC_PATH/config
    echo 0x19283ea0 > $DCC_PATH/config
    echo 0x19283f30 2 > $DCC_PATH/config
    echo 0x1928527c > $DCC_PATH/config
    echo 0x19285290 > $DCC_PATH/config
    echo 0x192854ec > $DCC_PATH/config
    echo 0x192854f4 > $DCC_PATH/config
    echo 0x19285514 > $DCC_PATH/config
    echo 0x1928551c > $DCC_PATH/config
    echo 0x19285524 > $DCC_PATH/config
    echo 0x19285548 > $DCC_PATH/config
    echo 0x19285550 > $DCC_PATH/config
    echo 0x19285558 > $DCC_PATH/config
    echo 0x192855b8 > $DCC_PATH/config
    echo 0x192855c0 > $DCC_PATH/config
    echo 0x192855ec > $DCC_PATH/config
    echo 0x19285860 > $DCC_PATH/config
    echo 0x19285870 > $DCC_PATH/config
    echo 0x192858a0 > $DCC_PATH/config
    echo 0x192858a8 > $DCC_PATH/config
    echo 0x192858b0 > $DCC_PATH/config
    echo 0x192858b8 > $DCC_PATH/config
    echo 0x192858d8 2 > $DCC_PATH/config
    echo 0x192858f4 > $DCC_PATH/config
    echo 0x192858fc > $DCC_PATH/config
    echo 0x19285920 > $DCC_PATH/config
    echo 0x19285928 > $DCC_PATH/config
    echo 0x19285944 > $DCC_PATH/config
    echo 0x19286604 > $DCC_PATH/config
    echo 0x1928660c > $DCC_PATH/config
    echo 0x19381e64 > $DCC_PATH/config
    echo 0x19381ea0 > $DCC_PATH/config
    echo 0x19381f30 2 > $DCC_PATH/config
    echo 0x19383e64 > $DCC_PATH/config
    echo 0x19383ea0 > $DCC_PATH/config
    echo 0x19383f30 2 > $DCC_PATH/config
    echo 0x1938527c > $DCC_PATH/config
    echo 0x19385290 > $DCC_PATH/config
    echo 0x193854ec > $DCC_PATH/config
    echo 0x193854f4 > $DCC_PATH/config
    echo 0x19385514 > $DCC_PATH/config
    echo 0x1938551c > $DCC_PATH/config
    echo 0x19385524 > $DCC_PATH/config
    echo 0x19385548 > $DCC_PATH/config
    echo 0x19385550 > $DCC_PATH/config
    echo 0x19385558 > $DCC_PATH/config
    echo 0x193855b8 > $DCC_PATH/config
    echo 0x193855c0 > $DCC_PATH/config
    echo 0x193855ec > $DCC_PATH/config
    echo 0x19385860 > $DCC_PATH/config
    echo 0x19385870 > $DCC_PATH/config
    echo 0x193858a0 > $DCC_PATH/config
    echo 0x193858a8 > $DCC_PATH/config
    echo 0x193858b0 > $DCC_PATH/config
    echo 0x193858b8 > $DCC_PATH/config
    echo 0x193858d8 2 > $DCC_PATH/config
    echo 0x193858f4 > $DCC_PATH/config
    echo 0x193858fc > $DCC_PATH/config
    echo 0x19385920 > $DCC_PATH/config
    echo 0x19385928 > $DCC_PATH/config
    echo 0x19385944 > $DCC_PATH/config
    echo 0x19386604 > $DCC_PATH/config
    echo 0x1938660c > $DCC_PATH/config

    #Pimem
    echo 0x610110 5 > $DCC_PATH/config

    # SHRM2
    echo 0x19032020 > $DCC_PATH/config
    echo 0x19032024 > $DCC_PATH/config
    echo 0x1908e01c > $DCC_PATH/config
    echo 0x1908e030 > $DCC_PATH/config
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1908e008 > $DCC_PATH/config
    echo 0x19032020 > $DCC_PATH/config
    echo 0x1908e948 > $DCC_PATH/config
    echo 0x19032024 > $DCC_PATH/config

    echo 0x19030040 0x1 1 > $DCC_PATH/config_write
    echo 0x1903005c 0x22C000 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config

    echo 0x1903005c 0x22C001 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C002 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C003 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C004 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C005 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C006 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C007 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C008 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C009 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C00A 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C00B 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C00C 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C00D 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C00E 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C00F 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C010 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C011 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C012 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C013 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C014 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C015 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C016 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C017 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C018 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C019 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C01A 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C01B 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C01C 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C01D 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C01E 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C01F 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C300 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C341 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005c 0x22C7B1 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    #End Link list #6
}

config_dcc_rpmh()
{
    echo 0xb281024 > $DCC_PATH/config
    echo 0xbde1034 > $DCC_PATH/config

    #RPMH_PDC_APSS
    echo 0xb201020 2 > $DCC_PATH/config
    echo 0xb211020 2 > $DCC_PATH/config
    echo 0xb221020 2 > $DCC_PATH/config
    echo 0xb231020 2 > $DCC_PATH/config
    echo 0xb204520 > $DCC_PATH/config
}

config_dcc_apss_rscc()
{
    #APSS_RSCC_RSC register
    echo 0x17a00010 > $DCC_PATH/config
    echo 0x17a10010 > $DCC_PATH/config
    echo 0x17a20010 > $DCC_PATH/config
    echo 0x17a30010 > $DCC_PATH/config
    echo 0x17a00030 > $DCC_PATH/config
    echo 0x17a10030 > $DCC_PATH/config
    echo 0x17a20030 > $DCC_PATH/config
    echo 0x17a30030 > $DCC_PATH/config
    echo 0x17a00038 > $DCC_PATH/config
    echo 0x17a10038 > $DCC_PATH/config
    echo 0x17a20038 > $DCC_PATH/config
    echo 0x17a30038 > $DCC_PATH/config
    echo 0x17a00040 > $DCC_PATH/config
    echo 0x17a10040 > $DCC_PATH/config
    echo 0x17a20040 > $DCC_PATH/config
    echo 0x17a30040 > $DCC_PATH/config
    echo 0x17a00048 > $DCC_PATH/config
    echo 0x17a00400 3 > $DCC_PATH/config
    echo 0x17a10400 3 > $DCC_PATH/config
    echo 0x17a20400 3 > $DCC_PATH/config
    echo 0x17a30400 3 > $DCC_PATH/config
}

config_dcc_misc()
{
    #secure WDOG register
    echo 0xc230000 6 > $DCC_PATH/config
    echo 0x17b020 > $DCC_PATH/config
    echo 0x17b030 > $DCC_PATH/config
    echo 0x17b028 > $DCC_PATH/config
    echo 0x120004 > $DCC_PATH/config
    echo 0x18b02c > $DCC_PATH/config
    echo 0x17B01C > $DCC_PATH/config
    echo 0x17B034 > $DCC_PATH/config
    echo 0x17B03C > $DCC_PATH/config
    echo 0x17B044 > $DCC_PATH/config
    echo 0x17B018 > $DCC_PATH/config
    echo 0x1C001B0 > $DCC_PATH/config
}

config_dcc_gict()
{
    echo 0x17120000 > $DCC_PATH/config
    echo 0x17120008 > $DCC_PATH/config
    echo 0x17120010 > $DCC_PATH/config
    echo 0x17120018 > $DCC_PATH/config
    echo 0x17120020 > $DCC_PATH/config
    echo 0x17120028 > $DCC_PATH/config
    echo 0x17120040 > $DCC_PATH/config
    echo 0x17120048 > $DCC_PATH/config
    echo 0x17120050 > $DCC_PATH/config
    echo 0x17120058 > $DCC_PATH/config
    echo 0x17120060 > $DCC_PATH/config
    echo 0x17120068 > $DCC_PATH/config
    echo 0x17120080 > $DCC_PATH/config
    echo 0x17120088 > $DCC_PATH/config
    echo 0x17120090 > $DCC_PATH/config
    echo 0x17120098 > $DCC_PATH/config
    echo 0x171200a0 > $DCC_PATH/config
    echo 0x171200a8 > $DCC_PATH/config
    echo 0x171200c0 > $DCC_PATH/config
    echo 0x171200c8 > $DCC_PATH/config
    echo 0x171200d0 > $DCC_PATH/config
    echo 0x171200d8 > $DCC_PATH/config
    echo 0x171200e0 > $DCC_PATH/config
    echo 0x171200e8 > $DCC_PATH/config
    echo 0x17120100 > $DCC_PATH/config
    echo 0x17120108 > $DCC_PATH/config
    echo 0x17120110 > $DCC_PATH/config
    echo 0x17120118 > $DCC_PATH/config
    echo 0x17120120 > $DCC_PATH/config
    echo 0x17120128 > $DCC_PATH/config
    echo 0x17120140 > $DCC_PATH/config
    echo 0x17120148 > $DCC_PATH/config
    echo 0x17120150 > $DCC_PATH/config
    echo 0x17120158 > $DCC_PATH/config
    echo 0x17120160 > $DCC_PATH/config
    echo 0x17120168 > $DCC_PATH/config
    echo 0x17120180 > $DCC_PATH/config
    echo 0x17120188 > $DCC_PATH/config
    echo 0x17120190 > $DCC_PATH/config
    echo 0x17120198 > $DCC_PATH/config
    echo 0x171201a0 > $DCC_PATH/config
    echo 0x171201a8 > $DCC_PATH/config
    echo 0x171201c0 > $DCC_PATH/config
    echo 0x171201c8 > $DCC_PATH/config
    echo 0x171201d0 > $DCC_PATH/config
    echo 0x171201d8 > $DCC_PATH/config
    echo 0x171201e0 > $DCC_PATH/config
    echo 0x171201e8 > $DCC_PATH/config
    echo 0x17120200 > $DCC_PATH/config
    echo 0x17120208 > $DCC_PATH/config
    echo 0x17120210 > $DCC_PATH/config
    echo 0x17120218 > $DCC_PATH/config
    echo 0x17120220 > $DCC_PATH/config
    echo 0x17120228 > $DCC_PATH/config
    echo 0x17120240 > $DCC_PATH/config
    echo 0x17120248 > $DCC_PATH/config
    echo 0x17120250 > $DCC_PATH/config
    echo 0x17120258 > $DCC_PATH/config
    echo 0x17120260 > $DCC_PATH/config
    echo 0x17120268 > $DCC_PATH/config
    echo 0x17120280 > $DCC_PATH/config
    echo 0x17120288 > $DCC_PATH/config
    echo 0x17120290 > $DCC_PATH/config
    echo 0x17120298 > $DCC_PATH/config
    echo 0x171202a0 > $DCC_PATH/config
    echo 0x171202a8 > $DCC_PATH/config
    echo 0x171202c0 > $DCC_PATH/config
    echo 0x171202c8 > $DCC_PATH/config
    echo 0x171202d0 > $DCC_PATH/config
    echo 0x171202d8 > $DCC_PATH/config
    echo 0x171202e0 > $DCC_PATH/config
    echo 0x171202e8 > $DCC_PATH/config
    echo 0x17120300 > $DCC_PATH/config
    echo 0x17120308 > $DCC_PATH/config
    echo 0x17120310 > $DCC_PATH/config
    echo 0x17120318 > $DCC_PATH/config
    echo 0x17120320 > $DCC_PATH/config
    echo 0x17120328 > $DCC_PATH/config
    echo 0x17120340 > $DCC_PATH/config
    echo 0x17120348 > $DCC_PATH/config
    echo 0x17120350 > $DCC_PATH/config
    echo 0x17120358 > $DCC_PATH/config
    echo 0x17120360 > $DCC_PATH/config
    echo 0x17120368 > $DCC_PATH/config
    echo 0x17120380 > $DCC_PATH/config
    echo 0x17120388 > $DCC_PATH/config
    echo 0x17120390 > $DCC_PATH/config
    echo 0x17120398 > $DCC_PATH/config
    echo 0x171203a0 > $DCC_PATH/config
    echo 0x171203a8 > $DCC_PATH/config
    echo 0x171203c0 > $DCC_PATH/config
    echo 0x171203c8 > $DCC_PATH/config
    echo 0x171203d0 > $DCC_PATH/config
    echo 0x171203d8 > $DCC_PATH/config
    echo 0x171203e0 > $DCC_PATH/config
    echo 0x171203e8 > $DCC_PATH/config
    echo 0x17120400 > $DCC_PATH/config
    echo 0x17120408 > $DCC_PATH/config
    echo 0x17120410 > $DCC_PATH/config
    echo 0x17120418 > $DCC_PATH/config
    echo 0x17120420 > $DCC_PATH/config
    echo 0x17120428 > $DCC_PATH/config
    echo 0x17120440 > $DCC_PATH/config
    echo 0x17120448 > $DCC_PATH/config
    echo 0x17120450 > $DCC_PATH/config
    echo 0x17120458 > $DCC_PATH/config
    echo 0x17120460 > $DCC_PATH/config
    echo 0x17120468 > $DCC_PATH/config
    echo 0x17120480 > $DCC_PATH/config
    echo 0x17120488 > $DCC_PATH/config
    echo 0x17120490 > $DCC_PATH/config
    echo 0x17120498 > $DCC_PATH/config
    echo 0x171204a0 > $DCC_PATH/config
    echo 0x171204a8 > $DCC_PATH/config
    echo 0x171204c0 > $DCC_PATH/config
    echo 0x171204c8 > $DCC_PATH/config
    echo 0x171204d0 > $DCC_PATH/config
    echo 0x171204d8 > $DCC_PATH/config
    echo 0x171204e0 > $DCC_PATH/config
    echo 0x171204e8 > $DCC_PATH/config
    echo 0x17120500 > $DCC_PATH/config
    echo 0x17120508 > $DCC_PATH/config
    echo 0x17120510 > $DCC_PATH/config
    echo 0x17120518 > $DCC_PATH/config
    echo 0x17120520 > $DCC_PATH/config
    echo 0x17120528 > $DCC_PATH/config
    echo 0x17120540 > $DCC_PATH/config
    echo 0x17120548 > $DCC_PATH/config
    echo 0x17120550 > $DCC_PATH/config
    echo 0x17120558 > $DCC_PATH/config
    echo 0x17120560 > $DCC_PATH/config
    echo 0x17120568 > $DCC_PATH/config
    echo 0x17120580 > $DCC_PATH/config
    echo 0x17120588 > $DCC_PATH/config
    echo 0x17120590 > $DCC_PATH/config
    echo 0x17120598 > $DCC_PATH/config
    echo 0x171205a0 > $DCC_PATH/config
    echo 0x171205a8 > $DCC_PATH/config
    echo 0x171205c0 > $DCC_PATH/config
    echo 0x171205c8 > $DCC_PATH/config
    echo 0x171205d0 > $DCC_PATH/config
    echo 0x171205d8 > $DCC_PATH/config
    echo 0x171205e0 > $DCC_PATH/config
    echo 0x171205e8 > $DCC_PATH/config
    echo 0x17120600 > $DCC_PATH/config
    echo 0x17120608 > $DCC_PATH/config
    echo 0x17120610 > $DCC_PATH/config
    echo 0x17120618 > $DCC_PATH/config
    echo 0x17120620 > $DCC_PATH/config
    echo 0x17120628 > $DCC_PATH/config
    echo 0x17120640 > $DCC_PATH/config
    echo 0x17120648 > $DCC_PATH/config
    echo 0x17120650 > $DCC_PATH/config
    echo 0x17120658 > $DCC_PATH/config
    echo 0x17120660 > $DCC_PATH/config
    echo 0x17120668 > $DCC_PATH/config
    echo 0x17120680 > $DCC_PATH/config
    echo 0x17120688 > $DCC_PATH/config
    echo 0x17120690 > $DCC_PATH/config
    echo 0x17120698 > $DCC_PATH/config
    echo 0x171206a0 > $DCC_PATH/config
    echo 0x171206a8 > $DCC_PATH/config
    echo 0x171206c0 > $DCC_PATH/config
    echo 0x171206c8 > $DCC_PATH/config
    echo 0x171206d0 > $DCC_PATH/config
    echo 0x171206d8 > $DCC_PATH/config
    echo 0x171206e0 > $DCC_PATH/config
    echo 0x171206e8 > $DCC_PATH/config
    echo 0x1712e000 > $DCC_PATH/config
}

config_dcc_core()
{
    # core hang
    echo 0x1740003c > $DCC_PATH/config

    #MIBU Debug registers

    #CHI (GNOC) Hang counters

    #SYSCO and other misc debug
    echo 0x17400438 > $DCC_PATH/config

    #PPUHWSTAT_STS

    #CPRh
    echo 0x17900908 > $DCC_PATH/config
    echo 0x17900c18 > $DCC_PATH/config
    echo 0x17901908 > $DCC_PATH/config
    echo 0x17901c18 > $DCC_PATH/config

    # pll status for all banks and all domains
    echo 0x17a80000 0x8007 > $DCC_PATH/config_write
    echo 0x17a80000 > $DCC_PATH/config
    echo 0x17a80024 0x0 > $DCC_PATH/config_write
    echo 0x17a80024 > $DCC_PATH/config
    echo 0x17a80020 0x0 > $DCC_PATH/config_write
    echo 0x17a80020 > $DCC_PATH/config
    echo 0x17a80038 > $DCC_PATH/config
    echo 0x17a80020 0x40 > $DCC_PATH/config_write
    echo 0x17a80020 > $DCC_PATH/config
    echo 0x17a80038 > $DCC_PATH/config
    echo 0x17a80020 0x80 > $DCC_PATH/config_write
    echo 0x17a80020 > $DCC_PATH/config
    echo 0x17a80038 > $DCC_PATH/config
    echo 0x17a80020 0xc0 > $DCC_PATH/config_write
    echo 0x17a80020 > $DCC_PATH/config
    echo 0x17a80038 > $DCC_PATH/config
    echo 0x17a80020 0x100 > $DCC_PATH/config_write
    echo 0x17a80020 > $DCC_PATH/config
    echo 0x17a80038 > $DCC_PATH/config
    echo 0x17a80020 0x140 > $DCC_PATH/config_write
    echo 0x17a80020 > $DCC_PATH/config
    echo 0x17a80038 > $DCC_PATH/config
    echo 0x17a80020 0x180 > $DCC_PATH/config_write
    echo 0x17a80020 > $DCC_PATH/config
    echo 0x17a80038 > $DCC_PATH/config
    echo 0x17a80020 0x1c0 > $DCC_PATH/config_write
    echo 0x17a80020 > $DCC_PATH/config
    echo 0x17a80038 > $DCC_PATH/config
    echo 0x17a80020 0x200 > $DCC_PATH/config_write
    echo 0x17a80020 > $DCC_PATH/config
    echo 0x17a80038 > $DCC_PATH/config
    echo 0x17a80020 0x240 > $DCC_PATH/config_write
    echo 0x17a80020 > $DCC_PATH/config
    echo 0x17a80038 > $DCC_PATH/config
    echo 0x17a80020 0x280 > $DCC_PATH/config_write
    echo 0x17a80020 > $DCC_PATH/config
    echo 0x17a80038 > $DCC_PATH/config
    echo 0x17a80020 0x2c0 > $DCC_PATH/config_write
    echo 0x17a80020 > $DCC_PATH/config
    echo 0x17a80038 > $DCC_PATH/config
    echo 0x17a80020 0x300 > $DCC_PATH/config_write
    echo 0x17a80020 > $DCC_PATH/config
    echo 0x17a80038 > $DCC_PATH/config
    echo 0x17a80020 0x340 > $DCC_PATH/config_write
    echo 0x17a80020 > $DCC_PATH/config
    echo 0x17a80038 > $DCC_PATH/config
    echo 0x17a80020 0x380 > $DCC_PATH/config_write
    echo 0x17a80020 > $DCC_PATH/config
    echo 0x17a80038 > $DCC_PATH/config
    echo 0x17a80020 0x3c0 > $DCC_PATH/config_write
    echo 0x17a80020 > $DCC_PATH/config
    echo 0x17a80038 > $DCC_PATH/config
    echo 0x17a80024 0x4000 > $DCC_PATH/config_write
    echo 0x17a80024 > $DCC_PATH/config
    echo 0x17a80020 0x0 > $DCC_PATH/config_write
    echo 0x17a80020 > $DCC_PATH/config
    echo 0x17a80020 0x0 > $DCC_PATH/config_write
    echo 0x17a80020 > $DCC_PATH/config
    echo 0x17a80020 0x0 > $DCC_PATH/config_write
    echo 0x17a80020 > $DCC_PATH/config
    echo 0x17a80038 > $DCC_PATH/config
    echo 0x17a80020 0x40 > $DCC_PATH/config_write
    echo 0x17a80020 > $DCC_PATH/config
    echo 0x17a80038 > $DCC_PATH/config

    echo 0x17a82000 0x8007 > $DCC_PATH/config_write
    echo 0x17a82000 > $DCC_PATH/config
    echo 0x17a82024 0x0 > $DCC_PATH/config_write
    echo 0x17a82024 > $DCC_PATH/config
    echo 0x17a82020 0x0 > $DCC_PATH/config_write
    echo 0x17a82020 > $DCC_PATH/config
    echo 0x17a82038 > $DCC_PATH/config
    echo 0x17a82020 0x40 > $DCC_PATH/config_write
    echo 0x17a82020 > $DCC_PATH/config
    echo 0x17a82038 > $DCC_PATH/config
    echo 0x17a82020 0x80 > $DCC_PATH/config_write
    echo 0x17a82020 > $DCC_PATH/config
    echo 0x17a82038 > $DCC_PATH/config
    echo 0x17a82020 0xc0 > $DCC_PATH/config_write
    echo 0x17a82020 > $DCC_PATH/config
    echo 0x17a82038 > $DCC_PATH/config
    echo 0x17a82020 0x100 > $DCC_PATH/config_write
    echo 0x17a82020 > $DCC_PATH/config
    echo 0x17a82038 > $DCC_PATH/config
    echo 0x17a82020 0x140 > $DCC_PATH/config_write
    echo 0x17a82020 > $DCC_PATH/config
    echo 0x17a82038 > $DCC_PATH/config
    echo 0x17a82020 0x180 > $DCC_PATH/config_write
    echo 0x17a82020 > $DCC_PATH/config
    echo 0x17a82038 > $DCC_PATH/config
    echo 0x17a82020 0x1c0 > $DCC_PATH/config_write
    echo 0x17a82020 > $DCC_PATH/config
    echo 0x17a82038 > $DCC_PATH/config
    echo 0x17a82020 0x200 > $DCC_PATH/config_write
    echo 0x17a82020 > $DCC_PATH/config
    echo 0x17a82038 > $DCC_PATH/config
    echo 0x17a82020 0x240 > $DCC_PATH/config_write
    echo 0x17a82020 > $DCC_PATH/config
    echo 0x17a82038 > $DCC_PATH/config
    echo 0x17a82020 0x280 > $DCC_PATH/config_write
    echo 0x17a82020 > $DCC_PATH/config
    echo 0x17a82038 > $DCC_PATH/config
    echo 0x17a82020 0x2c0 > $DCC_PATH/config_write
    echo 0x17a82020 > $DCC_PATH/config
    echo 0x17a82038 > $DCC_PATH/config
    echo 0x17a82020 0x300 > $DCC_PATH/config_write
    echo 0x17a82020 > $DCC_PATH/config
    echo 0x17a82038 > $DCC_PATH/config
    echo 0x17a82020 0x340 > $DCC_PATH/config_write
    echo 0x17a82020 > $DCC_PATH/config
    echo 0x17a82038 > $DCC_PATH/config
    echo 0x17a82020 0x380 > $DCC_PATH/config_write
    echo 0x17a82020 > $DCC_PATH/config
    echo 0x17a82038 > $DCC_PATH/config
    echo 0x17a82020 0x3c0 > $DCC_PATH/config_write
    echo 0x17a82020 > $DCC_PATH/config
    echo 0x17a82038 > $DCC_PATH/config
    echo 0x17a82024 0x4000 > $DCC_PATH/config_write
    echo 0x17a82024 > $DCC_PATH/config
    echo 0x17a82020 0x0 > $DCC_PATH/config_write
    echo 0x17a82020 > $DCC_PATH/config
    echo 0x17a82020 0x0 > $DCC_PATH/config_write
    echo 0x17a82020 > $DCC_PATH/config
    echo 0x17a82020 0x0 > $DCC_PATH/config_write
    echo 0x17a82020 > $DCC_PATH/config
    echo 0x17a82038 > $DCC_PATH/config
    echo 0x17a82020 0x40 > $DCC_PATH/config_write
    echo 0x17a82020 > $DCC_PATH/config
    echo 0x17a82038 > $DCC_PATH/config

    echo 0x17a84000 0x8007 > $DCC_PATH/config_write
    echo 0x17a84000 > $DCC_PATH/config
    echo 0x17a84024 0x0 > $DCC_PATH/config_write
    echo 0x17a84024 > $DCC_PATH/config
    echo 0x17a84020 0x0 > $DCC_PATH/config_write
    echo 0x17a84020 > $DCC_PATH/config
    echo 0x17a84038 > $DCC_PATH/config
    echo 0x17a84020 0x40 > $DCC_PATH/config_write
    echo 0x17a84020 > $DCC_PATH/config
    echo 0x17a84038 > $DCC_PATH/config
    echo 0x17a84020 0x80 > $DCC_PATH/config_write
    echo 0x17a84020 > $DCC_PATH/config
    echo 0x17a84038 > $DCC_PATH/config
    echo 0x17a84020 0xc0 > $DCC_PATH/config_write
    echo 0x17a84020 > $DCC_PATH/config
    echo 0x17a84038 > $DCC_PATH/config
    echo 0x17a84020 0x100 > $DCC_PATH/config_write
    echo 0x17a84020 > $DCC_PATH/config
    echo 0x17a84038 > $DCC_PATH/config
    echo 0x17a84020 0x140 > $DCC_PATH/config_write
    echo 0x17a84020 > $DCC_PATH/config
    echo 0x17a84038 > $DCC_PATH/config
    echo 0x17a84020 0x180 > $DCC_PATH/config_write
    echo 0x17a84020 > $DCC_PATH/config
    echo 0x17a84038 > $DCC_PATH/config
    echo 0x17a84020 0x1c0 > $DCC_PATH/config_write
    echo 0x17a84020 > $DCC_PATH/config
    echo 0x17a84038 > $DCC_PATH/config
    echo 0x17a84020 0x200 > $DCC_PATH/config_write
    echo 0x17a84020 > $DCC_PATH/config
    echo 0x17a84038 > $DCC_PATH/config
    echo 0x17a84020 0x240 > $DCC_PATH/config_write
    echo 0x17a84020 > $DCC_PATH/config
    echo 0x17a84038 > $DCC_PATH/config
    echo 0x17a84020 0x280 > $DCC_PATH/config_write
    echo 0x17a84020 > $DCC_PATH/config
    echo 0x17a84038 > $DCC_PATH/config
    echo 0x17a84020 0x2c0 > $DCC_PATH/config_write
    echo 0x17a84020 > $DCC_PATH/config
    echo 0x17a84038 > $DCC_PATH/config
    echo 0x17a84020 0x300 > $DCC_PATH/config_write
    echo 0x17a84020 > $DCC_PATH/config
    echo 0x17a84038 > $DCC_PATH/config
    echo 0x17a84020 0x340 > $DCC_PATH/config_write
    echo 0x17a84020 > $DCC_PATH/config
    echo 0x17a84038 > $DCC_PATH/config
    echo 0x17a84020 0x380 > $DCC_PATH/config_write
    echo 0x17a84020 > $DCC_PATH/config
    echo 0x17a84038 > $DCC_PATH/config
    echo 0x17a84020 0x3c0 > $DCC_PATH/config_write
    echo 0x17a84020 > $DCC_PATH/config
    echo 0x17a84038 > $DCC_PATH/config
    echo 0x17a84024 0x4000 > $DCC_PATH/config_write
    echo 0x17a84024 > $DCC_PATH/config
    echo 0x17a84020 0x0 > $DCC_PATH/config_write
    echo 0x17a84020 > $DCC_PATH/config
    echo 0x17a84020 0x0 > $DCC_PATH/config_write
    echo 0x17a84020 > $DCC_PATH/config
    echo 0x17a84020 0x0 > $DCC_PATH/config_write
    echo 0x17a84020 > $DCC_PATH/config
    echo 0x17a84038 > $DCC_PATH/config
    echo 0x17a84020 0x40 > $DCC_PATH/config_write
    echo 0x17a84020 > $DCC_PATH/config
    echo 0x17a84038 > $DCC_PATH/config

    echo 0x17a86000 0x8007 > $DCC_PATH/config_write
    echo 0x17a86000 > $DCC_PATH/config
    echo 0x17a86024 0x0 > $DCC_PATH/config_write
    echo 0x17a86024 > $DCC_PATH/config
    echo 0x17a86020 0x0 > $DCC_PATH/config_write
    echo 0x17a86020 > $DCC_PATH/config
    echo 0x17a86038 > $DCC_PATH/config
    echo 0x17a86020 0x40 > $DCC_PATH/config_write
    echo 0x17a86020 > $DCC_PATH/config
    echo 0x17a86038 > $DCC_PATH/config
    echo 0x17a86020 0x80 > $DCC_PATH/config_write
    echo 0x17a86020 > $DCC_PATH/config
    echo 0x17a86038 > $DCC_PATH/config
    echo 0x17a86020 0xc0 > $DCC_PATH/config_write
    echo 0x17a86020 > $DCC_PATH/config
    echo 0x17a86038 > $DCC_PATH/config
    echo 0x17a86020 0x100 > $DCC_PATH/config_write
    echo 0x17a86020 > $DCC_PATH/config
    echo 0x17a86038 > $DCC_PATH/config
    echo 0x17a86020 0x140 > $DCC_PATH/config_write
    echo 0x17a86020 > $DCC_PATH/config
    echo 0x17a86038 > $DCC_PATH/config
    echo 0x17a86020 0x180 > $DCC_PATH/config_write
    echo 0x17a86020 > $DCC_PATH/config
    echo 0x17a86038 > $DCC_PATH/config
    echo 0x17a86020 0x1c0 > $DCC_PATH/config_write
    echo 0x17a86020 > $DCC_PATH/config
    echo 0x17a86038 > $DCC_PATH/config
    echo 0x17a86020 0x200 > $DCC_PATH/config_write
    echo 0x17a86020 > $DCC_PATH/config
    echo 0x17a86038 > $DCC_PATH/config
    echo 0x17a86020 0x240 > $DCC_PATH/config_write
    echo 0x17a86020 > $DCC_PATH/config
    echo 0x17a86038 > $DCC_PATH/config
    echo 0x17a86020 0x280 > $DCC_PATH/config_write
    echo 0x17a86020 > $DCC_PATH/config
    echo 0x17a86038 > $DCC_PATH/config
    echo 0x17a86020 0x2c0 > $DCC_PATH/config_write
    echo 0x17a86020 > $DCC_PATH/config
    echo 0x17a86038 > $DCC_PATH/config
    echo 0x17a86020 0x300 > $DCC_PATH/config_write
    echo 0x17a86020 > $DCC_PATH/config
    echo 0x17a86038 > $DCC_PATH/config
    echo 0x17a86020 0x340 > $DCC_PATH/config_write
    echo 0x17a86020 > $DCC_PATH/config
    echo 0x17a86038 > $DCC_PATH/config
    echo 0x17a86020 0x380 > $DCC_PATH/config_write
    echo 0x17a86020 > $DCC_PATH/config
    echo 0x17a86038 > $DCC_PATH/config
    echo 0x17a86020 0x3c0 > $DCC_PATH/config_write
    echo 0x17a86020 > $DCC_PATH/config
    echo 0x17a86038 > $DCC_PATH/config
    echo 0x17a86024 0x4000 > $DCC_PATH/config_write
    echo 0x17a86024 > $DCC_PATH/config
    echo 0x17a86020 0x0 > $DCC_PATH/config_write
    echo 0x17a86020 > $DCC_PATH/config
    echo 0x17a86020 0x0 > $DCC_PATH/config_write
    echo 0x17a86020 > $DCC_PATH/config
    echo 0x17a86020 0x0 > $DCC_PATH/config_write
    echo 0x17a86020 > $DCC_PATH/config
    echo 0x17a86038 > $DCC_PATH/config
    echo 0x17a86020 0x40 > $DCC_PATH/config_write
    echo 0x17a86020 > $DCC_PATH/config
    echo 0x17a86038 > $DCC_PATH/config

    #rpmh
    echo 0xc201244 > $DCC_PATH/config
    echo 0xc202244 > $DCC_PATH/config

    #L3-ACD
    echo 0x17a94030 > $DCC_PATH/config
    echo 0x17a9408c > $DCC_PATH/config
    echo 0x17a9409c 0x78 > $DCC_PATH/config_write
    echo 0x17a9409c 0x0  > $DCC_PATH/config_write
    echo 0x17a94048 0x1  > $DCC_PATH/config_write
    echo 0x17a94090 0x0  > $DCC_PATH/config_write
    echo 0x17a94090 0x25 > $DCC_PATH/config_write
    echo 0x17a94098 > $DCC_PATH/config
    echo 0x17a94048 0x1D > $DCC_PATH/config_write
    echo 0x17a94090 0x0  > $DCC_PATH/config_write
    echo 0x17a94090 0x25 > $DCC_PATH/config_write
    echo 0x17a94098 > $DCC_PATH/config

    #SILVER-ACD
    echo 0x17a90030 > $DCC_PATH/config
    echo 0x17a9008c > $DCC_PATH/config
    echo 0x17a9009c 0x78 > $DCC_PATH/config_write
    echo 0x17a9009c 0x0  > $DCC_PATH/config_write
    echo 0x17a90048 0x1  > $DCC_PATH/config_write
    echo 0x17a90090 0x0  > $DCC_PATH/config_write
    echo 0x17a90090 0x25 > $DCC_PATH/config_write
    echo 0x17a90098 > $DCC_PATH/config
    echo 0x17a90048 0x1D > $DCC_PATH/config_write
    echo 0x17a90090 0x0  > $DCC_PATH/config_write
    echo 0x17a90090 0x25 > $DCC_PATH/config_write
    echo 0x17a90098 > $DCC_PATH/config


    #GOLD-ACD
    echo 0x17a92030 > $DCC_PATH/config
    echo 0x17a9208c > $DCC_PATH/config
    echo 0x17a9209c 0x78 > $DCC_PATH/config_write
    echo 0x17a9209c 0x0  > $DCC_PATH/config_write
    echo 0x17a92048 0x1  > $DCC_PATH/config_write
    echo 0x17a92090 0x0  > $DCC_PATH/config_write
    echo 0x17a92090 0x25 > $DCC_PATH/config_write
    echo 0x17a92098 > $DCC_PATH/config
    echo 0x17a92048 0x1D > $DCC_PATH/config_write
    echo 0x17a92090 0x0  > $DCC_PATH/config_write
    echo 0x17a92090 0x25 > $DCC_PATH/config_write
    echo 0x17a92098 > $DCC_PATH/config

    #GOLDPLUS-ACD
    echo 0x17a96030 > $DCC_PATH/config
    echo 0x17a9608c > $DCC_PATH/config
    echo 0x17a9609c 0x78 > $DCC_PATH/config_write
    echo 0x17a9609c 0x0  > $DCC_PATH/config_write
    echo 0x17a96048 0x1  > $DCC_PATH/config_write
    echo 0x17a96090 0x0  > $DCC_PATH/config_write
    echo 0x17a96090 0x25 > $DCC_PATH/config_write
    echo 0x17a96098 > $DCC_PATH/config
    echo 0x17a96048 0x1D > $DCC_PATH/config_write
    echo 0x17a96090 0x0  > $DCC_PATH/config_write
    echo 0x17a96090 0x25 > $DCC_PATH/config_write
    echo 0x17a96098 > $DCC_PATH/config

    echo 0x13822000 > $DCC_PATH/config

    #Security Control Core for Binning info
    echo 0x221c21c4 > $DCC_PATH/config

    #SoC version
    echo 0x1fc8000 > $DCC_PATH/config

    #WDOG BIT Config
    echo 0x17400038 > $DCC_PATH/config
}
config_apss_pwr_state()
{
    #TODO: need to be updated
}

config_dcc_gic()
{
    echo 0x17100104 29 > $DCC_PATH/config
    echo 0x17100204 29 > $DCC_PATH/config
    echo 0x17100384 29 > $DCC_PATH/config
}

config_adsp()
{
    echo 0xb2b1020 > $DCC_PATH/config
}

enable_dcc_pll_status()
{
   #TODO: need to be updated

}

config_dcc_tsens()
{
    echo 0xc222004 > $DCC_PATH/config
    echo 0xc263014 > $DCC_PATH/config
    echo 0xc2630e0 > $DCC_PATH/config
    echo 0xc2630ec > $DCC_PATH/config
    echo 0xc2630a0 16 > $DCC_PATH/config
    echo 0xc2630e8 > $DCC_PATH/config
    echo 0xc26313c > $DCC_PATH/config
    echo 0xc223004 > $DCC_PATH/config
    echo 0xc265014 > $DCC_PATH/config
    echo 0xc2650e0 > $DCC_PATH/config
    echo 0xc2650ec > $DCC_PATH/config
    echo 0xc2650a0 16 > $DCC_PATH/config
    echo 0xc2650e8 > $DCC_PATH/config
    echo 0xc26513c > $DCC_PATH/config
}

config_smmu()
{
    echo 0x15002204 > $DCC_PATH/config
    #SMMU_500_APPS_REG_WRAPPER_BASE=0x151CC000
    #ANOC_1

    echo 0x1a000c 2 > $DCC_PATH/config

    #let "APPS_SMMU_DEBUG_TESTBUS_SEL_ANOC_1_SEC = $SMMU_500_APPS_REG_WRAPPER_BASE+0x4050 = 0x151D0050"
    #let "APPS_SMMU_DEBUG_TESTBUS_ANOC_1_SEC = $SMMU_500_APPS_REG_WRAPPER_BASE+0x4058 = 0x151D0058"

    echo 0x151d0050 0x40 > $DCC_PATH/config_write #APPS_SMMU_DEBUG_TESTBUS_SEL_ANOC_1_SEC
    echo 0x151d0058 > $DCC_PATH/config

    echo 0x151d0050 0x80 > $DCC_PATH/config_write #APPS_SMMU_DEBUG_TESTBUS_SEL_ANOC_1_SEC
    echo 0x151d0058 > $DCC_PATH/config

    echo 0x151d0050 0xC0 > $DCC_PATH/config_write #APPS_SMMU_DEBUG_TESTBUS_SEL_ANOC_1_SEC
    echo 0x151d0058 > $DCC_PATH/config

    echo 0x151d0050 0x87 > $DCC_PATH/config_write #APPS_SMMU_DEBUG_TESTBUS_SEL_ANOC_1_SEC
    echo 0x151d0058 > $DCC_PATH/config

    echo 0x151d0050 0xAF > $DCC_PATH/config_write #APPS_SMMU_DEBUG_TESTBUS_SEL_ANOC_1_SEC
    echo 0x151d0058 > $DCC_PATH/config

    echo 0x151d0050 0xBC > $DCC_PATH/config_write #APPS_SMMU_DEBUG_TESTBUS_SEL_ANOC_1_SEC
    echo 0x151d0058 > $DCC_PATH/config

    #ANOC_2
    echo 0x1a0014 2 > $DCC_PATH/config

    #let "APPS_SMMU_DEBUG_TESTBUS_SEL_ANOC_2_HLOS1_NS = $SMMU_500_APPS_REG_WRAPPER_BASE+0x9050 = 0x151D5050"
    #let "APPS_SMMU_DEBUG_TESTBUS_ANOC_2_HLOS1_NS = $SMMU_500_APPS_REG_WRAPPER_BASE+0x9058 = 0x151D5058"

    echo 0x151d5050 0x40 > $DCC_PATH/config_write
    echo 0x151d5058 > $DCC_PATH/config

    echo 0x151d5050 0x80 > $DCC_PATH/config_write
    echo 0x151d5058 > $DCC_PATH/config

    echo 0x151d5050 0xC0 > $DCC_PATH/config_write
    echo 0x151d5058 > $DCC_PATH/config

    echo 0x151d5050 0x87 > $DCC_PATH/config_write
    echo 0x151d5058 > $DCC_PATH/config

    echo 0x151d5050 0xAF > $DCC_PATH/config_write
    echo 0x151d5058 > $DCC_PATH/config

    echo 0x151d5050 0xBC > $DCC_PATH/config_write
    echo 0x151d5058 > $DCC_PATH/config

    #MNOC_SF_0
    echo 0x12c018 2 > $DCC_PATH/config

    #let "APPS_SMMU_DEBUG_TESTBUS_SEL_MNOC_SF_0_HLOS1_NS = $SMMU_500_APPS_REG_WRAPPER_BASE+0x25050 = 0x151F1050"
    #let "APPS_SMMU_DEBUG_TESTBUS_MNOC_SF_0_HLOS1_NS = $SMMU_500_APPS_REG_WRAPPER_BASE+0x25058 = 0x151F1058"

    echo 0x151f1050 0x40 > $DCC_PATH/config_write #APPS_SMMU_DEBUG_TESTBUS_SEL_MNOC_SF_0_HLOS1_NS(0x151F1050)
    echo 0x151f1058 > $DCC_PATH/config

    echo 0x151f1050 0x80 > $DCC_PATH/config_write
    echo 0x151f1058 > $DCC_PATH/config
    #okay till here

    echo 0x151f1050 0xC0 > $DCC_PATH/config_write
    echo 0x151f1058 > $DCC_PATH/config

    echo 0x151f1050 0x87 > $DCC_PATH/config_write
    echo 0x151f1058 > $DCC_PATH/config

    echo 0x151f1050 0xAF > $DCC_PATH/config_write
    echo 0x151f1058 > $DCC_PATH/config

    echo 0x151f1050 0xBC > $DCC_PATH/config_write
    echo 0x151f1058 > $DCC_PATH/config



    #MNOC_SF_1
    echo 0x12c024 > $DCC_PATH/config
    echo 0x12c020 > $DCC_PATH/config

    #let "APPS_SMMU_DEBUG_TESTBUS_SEL_MNOC_SF_1_HLOS1_NS = $SMMU_500_APPS_REG_WRAPPER_BASE+0x29050 = 0x151F5050"
    #let "APPS_SMMU_DEBUG_TESTBUS_MNOC_SF_1_HLOS1_NS = $SMMU_500_APPS_REG_WRAPPER_BASE+0x29058 = 0x151F5058"

    echo 0x151f5050 0x40 > $DCC_PATH/config_write #APPS_SMMU_DEBUG_TESTBUS_SEL_MNOC_SF_1_HLOS1_NS(0x151F5050)
    echo 0x151f5058 > $DCC_PATH/config
    #
    echo 0x151f5050 0x80 > $DCC_PATH/config_write
    echo 0x151f5058 > $DCC_PATH/config

    echo 0x151f5050 0xC0 > $DCC_PATH/config_write
    echo 0x151f5058 > $DCC_PATH/config
    #
    echo 0x151f5050 0x87 > $DCC_PATH/config_write
    echo 0x151f5058 > $DCC_PATH/config
    #
    echo 0x151f5050 0xAF > $DCC_PATH/config_write
    echo 0x151f5058 > $DCC_PATH/config
    #
    echo 0x151f5050 0xBC > $DCC_PATH/config_write
    echo 0x151f5058 > $DCC_PATH/config

    ##MNOC_HF_0
    echo 0x12c02c > $DCC_PATH/config
    echo 0x12c028 > $DCC_PATH/config

    #let "APPS_SMMU_DEBUG_TESTBUS_SEL_MNOC_HF_0_HLOS1_NS = $SMMU_500_APPS_REG_WRAPPER_BASE+0xD050 = 0x151D9050"
    #let "APPS_SMMU_DEBUG_TESTBUS_MNOC_HF_0_HLOS1_NS = $SMMU_500_APPS_REG_WRAPPER_BASE+0xD058 = 0x151D9058"

    echo 0x151d9050 0x40 > $DCC_PATH/config_write #APPS_SMMU_DEBUG_TESTBUS_SEL_MNOC_HF_0_HLOS1_NS(0x151D9050)
    echo 0x151d9058 > $DCC_PATH/config

    echo 0x151d9050 0x80 > $DCC_PATH/config_write
    echo 0x151d9058 > $DCC_PATH/config

    echo 0x151d9050 0xC0 > $DCC_PATH/config_write
    echo 0x151d9058 > $DCC_PATH/config

    echo 0x151d9050 0x87 > $DCC_PATH/config_write
    echo 0x151d9058 > $DCC_PATH/config

    echo 0x151d9050 0xAF > $DCC_PATH/config_write
    echo 0x151d9058 > $DCC_PATH/config

    echo 0x151d9050 0xBC > $DCC_PATH/config_write
    echo 0x151d9058 > $DCC_PATH/config

    #MNOC_HF_1
    echo 0x12c034 > $DCC_PATH/config
    echo 0x12c030 > $DCC_PATH/config

    #let "APPS_SMMU_DEBUG_TESTBUS_SEL_MNOC_HF_1_HLOS1_NS = $SMMU_500_APPS_REG_WRAPPER_BASE+0x11050 = 0x151DD050"
    #let "APPS_SMMU_DEBUG_TESTBUS_MNOC_HF_1_HLOS1_NS = $SMMU_500_APPS_REG_WRAPPER_BASE+0x11058 = 0x151DD058"

    echo 0x151dd050 0x40 > $DCC_PATH/config_write #APPS_SMMU_DEBUG_TESTBUS_SEL_MNOC_HF_1_HLOS1_NS(0x151DD050)
    echo 0x151dd058 > $DCC_PATH/config

    echo 0x151dd050 0x80 > $DCC_PATH/config_write
    echo 0x151dd058 > $DCC_PATH/config

    echo 0x151dd050 0xC0 > $DCC_PATH/config_write
    echo 0x151dd058 > $DCC_PATH/config

    echo 0x151dd050 0x87 > $DCC_PATH/config_write
    echo 0x151dd058 > $DCC_PATH/config

    echo 0x151dd050 0xAF > $DCC_PATH/config_write
    echo 0x151dd058 > $DCC_PATH/config

    echo 0x151dd050 0xBC > $DCC_PATH/config_write
    echo 0x151dd058 > $DCC_PATH/config


    #COMPUTE_DSP_0
    echo 0x1a9018 > $DCC_PATH/config
    echo 0x1a9014 > $DCC_PATH/config

    #let "APPS_SMMU_DEBUG_TESTBUS_SEL_COMPUTE_DSP_0_HLOS1_NS = $SMMU_500_APPS_REG_WRAPPER_BASE+0x19050 = 0x151E5050"
    #let "APPS_SMMU_DEBUG_TESTBUS_COMPUTE_DSP_0_HLOS1_NS = $SMMU_500_APPS_REG_WRAPPER_BASE+0x19058 = 0x151E5058"

    echo 0x151e5050 0x40 > $DCC_PATH/config_write #APPS_SMMU_DEBUG_TESTBUS_SEL_COMPUTE_DSP_0_HLOS1_NS(0x151E5050)
    echo 0x151e5058 > $DCC_PATH/config

    echo 0x151e5050 0x80 > $DCC_PATH/config_write
    echo 0x151e5058 > $DCC_PATH/config

    echo 0x151e5050 0xC0 > $DCC_PATH/config_write
    echo 0x151e5058 > $DCC_PATH/config

    echo 0x151e5050 0x87 > $DCC_PATH/config_write
    echo 0x151e5058 > $DCC_PATH/config

    echo 0x151e5050 0xAF > $DCC_PATH/config_write
    echo 0x151e5058 > $DCC_PATH/config

    echo 0x151e5050 0xBC > $DCC_PATH/config_write
    echo 0x151e5058 > $DCC_PATH/config

    ##COMPUTE_DSP_1
    echo 0x1a9020 > $DCC_PATH/config
    echo 0x1a901c > $DCC_PATH/config

    #let "APPS_SMMU_DEBUG_TESTBUS_SEL_COMPUTE_DSP_1_HLOS1_NS = $SMMU_500_APPS_REG_WRAPPER_BASE+0x15050 = 0x151E1050"
    #let "APPS_SMMU_DEBUG_TESTBUS_COMPUTE_DSP_1_HLOS1_NS = $SMMU_500_APPS_REG_WRAPPER_BASE+0x15058 = 0x151E1058"

    echo 0x151e1050 0x40 > $DCC_PATH/config_write #APPS_SMMU_DEBUG_TESTBUS_SEL_COMPUTE_DSP_1_HLOS1_NS(0x151E1050)
    echo 0x151e1058 > $DCC_PATH/config

    echo 0x151e1050 0x80 > $DCC_PATH/config_write
    echo 0x151e1058 > $DCC_PATH/config

    echo 0x151e1050 0xC0 > $DCC_PATH/config_write
    echo 0x151e1058 > $DCC_PATH/config

    echo 0x151e1050 0x87 > $DCC_PATH/config_write
    echo 0x151e1058 > $DCC_PATH/config

    echo 0x151e1050 0xAF > $DCC_PATH/config_write
    echo 0x151e1058 > $DCC_PATH/config

    echo 0x151e1050 0xBC > $DCC_PATH/config_write
    echo 0x151e1058 > $DCC_PATH/config

    ##LPASS
    echo 0x1a0008 > $DCC_PATH/config
    echo 0x1a0004 > $DCC_PATH/config

    #let "APPS_SMMU_DEBUG_TESTBUS_SEL_LPASS_HLOS1_NS = $SMMU_500_APPS_REG_WRAPPER_BASE+0x1D050 = 0x151E9050"
    #let "APPS_SMMU_DEBUG_TESTBUS_LPASS_HLOS1_NS = $SMMU_500_APPS_REG_WRAPPER_BASE+0x1D058 = 0x151E9058"

    echo 0x151e9050 0x40 > $DCC_PATH/config_write #APPS_SMMU_DEBUG_TESTBUS_SEL_LPASS_HLOS1_NS(0x151E9050)
    echo 0x151e9058 > $DCC_PATH/config

    echo 0x151e9050 0x80 > $DCC_PATH/config_write
    echo 0x151e9058 > $DCC_PATH/config

    echo 0x151e9050 0xC0 > $DCC_PATH/config_write
    echo 0x151e9058 > $DCC_PATH/config

    echo 0x151e9050 0x87 > $DCC_PATH/config_write
    echo 0x151e9058 > $DCC_PATH/config

    echo 0x151e9050 0xAF > $DCC_PATH/config_write
    echo 0x151e9058 > $DCC_PATH/config

    echo 0x151e9050 0xBC > $DCC_PATH/config_write
    echo 0x151e9058 > $DCC_PATH/config

    ##ANOC_PCIE
    echo 0x120028 > $DCC_PATH/config
    echo 0x120024 > $DCC_PATH/config

    #let "APPS_SMMU_DEBUG_TESTBUS_SEL_ANOC_PCIE_HLOS1_NS = $SMMU_500_APPS_REG_WRAPPER_BASE+0x21050 = 0x151ED050"
    #let "APPS_SMMU_DEBUG_TESTBUS_ANOC_PCIE_HLOS1_NS = $SMMU_500_APPS_REG_WRAPPER_BASE+0x21058 = 0x151ED058"

    echo 0x151ed050 0x40 > $DCC_PATH/config_write #APPS_SMMU_DEBUG_TESTBUS_SEL_ANOC_PCIE_HLOS1_NS(0x151ED050)
    echo 0x151ed058 > $DCC_PATH/config

    echo 0x151ed050 0x80 > $DCC_PATH/config_write
    echo 0x151ed058 > $DCC_PATH/config

    echo 0x151ed050 0xC0 > $DCC_PATH/config_write
    echo 0x151ed058 > $DCC_PATH/config

    echo 0x151ed050 0x87 > $DCC_PATH/config_write
    echo 0x151ed058 > $DCC_PATH/config

    echo 0x151ed050 0xAF > $DCC_PATH/config_write
    echo 0x151ed058 > $DCC_PATH/config

    echo 0x151ed050 0xBC > $DCC_PATH/config_write
    echo 0x151ed058 > $DCC_PATH/config

    #TCU change
    echo 0x193008 2 > $DCC_PATH/config
    #
    echo 0x15002670 > $DCC_PATH/config
    echo 0x15002204 > $DCC_PATH/config
    echo 0x150025dc > $DCC_PATH/config
    echo 0x150075dc > $DCC_PATH/config
    echo 0x15002300 > $DCC_PATH/config
    echo 0x150022fc > $DCC_PATH/config
    echo 0x15002648 > $DCC_PATH/config

}

config_gpu()
{
    echo 0x3d0201c > $DCC_PATH/config
    echo 0x3d00000 > $DCC_PATH/config
    echo 0x3d00008 > $DCC_PATH/config
    echo 0x3d00044 > $DCC_PATH/config
    echo 0x3d00058 6 > $DCC_PATH/config
    echo 0x3d0007c 20 > $DCC_PATH/config
    echo 0x3d000e0 5 > $DCC_PATH/config
    echo 0x3d00108 > $DCC_PATH/config
    echo 0x3d00110 > $DCC_PATH/config
    echo 0x3d0011c > $DCC_PATH/config
    echo 0x3d00124 2 > $DCC_PATH/config
    echo 0x3d00140 > $DCC_PATH/config
    echo 0x3d00158 > $DCC_PATH/config
    echo 0x3d002b4 2 > $DCC_PATH/config
    echo 0x3d002c0 > $DCC_PATH/config
    echo 0x3d002d0 > $DCC_PATH/config
    echo 0x3d002e0 > $DCC_PATH/config
    echo 0x3d002f0 > $DCC_PATH/config
    echo 0x3d00300 > $DCC_PATH/config
    echo 0x3d00310 > $DCC_PATH/config
    echo 0x3d00320 > $DCC_PATH/config
    echo 0x3d00330 > $DCC_PATH/config
    echo 0x3d00340 > $DCC_PATH/config
    echo 0x3d00350 > $DCC_PATH/config
    echo 0x3d00360 > $DCC_PATH/config
    echo 0x3d00370 > $DCC_PATH/config
    echo 0x3d00380 > $DCC_PATH/config
    echo 0x3d00390 > $DCC_PATH/config
    echo 0x3d003a0 > $DCC_PATH/config
    echo 0x3d003b0 > $DCC_PATH/config
    echo 0x3d003c0 > $DCC_PATH/config
    echo 0x3d003d0 > $DCC_PATH/config
    echo 0x3d003e0 > $DCC_PATH/config
    echo 0x3d00400 > $DCC_PATH/config
    echo 0x3d00410 8 > $DCC_PATH/config
    echo 0x3d0043c 15 > $DCC_PATH/config
    echo 0x3d00800 14 > $DCC_PATH/config
    echo 0x3d00840 4 > $DCC_PATH/config
    echo 0x3d00854 41 > $DCC_PATH/config
    echo 0x3d01444 > $DCC_PATH/config
    echo 0x3d014d4 > $DCC_PATH/config
    echo 0x3d017f0 4 > $DCC_PATH/config
    echo 0x3d99800 8 > $DCC_PATH/config
    echo 0x3d99828 > $DCC_PATH/config
    echo 0x3d9983c > $DCC_PATH/config
    echo 0x3d998ac > $DCC_PATH/config
    echo 0x18101c 2 > $DCC_PATH/config
    echo 0x3d94000 2 > $DCC_PATH/config
    echo 0x3d95000 4 > $DCC_PATH/config
    echo 0x3d96000 4 > $DCC_PATH/config
    echo 0x3d97000 4 > $DCC_PATH/config
    echo 0x3d98000 4 > $DCC_PATH/config
    echo 0x3d99000 6 > $DCC_PATH/config
    echo 0x3d99050 10 > $DCC_PATH/config
    echo 0x3d990a8 2 > $DCC_PATH/config
    echo 0x3d990b8 3 > $DCC_PATH/config
    echo 0x3d990c8 > $DCC_PATH/config
    echo 0x3d99104 8 > $DCC_PATH/config
    echo 0x3d99130 2 > $DCC_PATH/config
    echo 0x3d9913c 7 > $DCC_PATH/config
    echo 0x3d99198 3 > $DCC_PATH/config
    echo 0x3d991e0 3 > $DCC_PATH/config
    echo 0x3d99224 2 > $DCC_PATH/config
    echo 0x3d99280 4 > $DCC_PATH/config
    echo 0x3d992cc 3 > $DCC_PATH/config
    echo 0x3d99314 3 > $DCC_PATH/config
    echo 0x3d99358 3 > $DCC_PATH/config
    echo 0x3d993a0 2 > $DCC_PATH/config
    echo 0x3d993e4 4 > $DCC_PATH/config
    echo 0x3d9942c 2 > $DCC_PATH/config
    echo 0x3d99470 3 > $DCC_PATH/config
    echo 0x3d99500 4 > $DCC_PATH/config
    echo 0x3d99528 39 > $DCC_PATH/config
    echo 0x3d90000 15 > $DCC_PATH/config
    echo 0x3d91000 15 > $DCC_PATH/config
    echo 0x3de0000 21 > $DCC_PATH/config
    echo 0x3de00d0 > $DCC_PATH/config
    echo 0x3de00d8 > $DCC_PATH/config
    echo 0x3de0100 3 > $DCC_PATH/config
    echo 0x3de0200 5 > $DCC_PATH/config
    echo 0x3de0400 3 > $DCC_PATH/config
    echo 0x3de0450 > $DCC_PATH/config
    echo 0x3de0460 2 > $DCC_PATH/config
    echo 0x3de0490 11 > $DCC_PATH/config
    echo 0x3de0500 > $DCC_PATH/config
    echo 0x3de0600 > $DCC_PATH/config
    echo 0x3de0d00 2 > $DCC_PATH/config
    echo 0x3de0d10 4 > $DCC_PATH/config
    echo 0x3de0d30 5 > $DCC_PATH/config
    echo 0x3de0fb0 4 > $DCC_PATH/config
    echo 0x3de0fd0 5 > $DCC_PATH/config
    echo 0x3de1250 4 > $DCC_PATH/config
    echo 0x3de1270 5 > $DCC_PATH/config
    echo 0x3de14f0 4 > $DCC_PATH/config
    echo 0x3de1510 5 > $DCC_PATH/config
    echo 0x3de3d44 > $DCC_PATH/config
    echo 0x3de3d4c 2 > $DCC_PATH/config
    echo 0x3d8ec0c > $DCC_PATH/config
    echo 0x3d8ec14 2 > $DCC_PATH/config
    echo 0x3d8ec30 3 > $DCC_PATH/config
    echo 0x3d8ec40 4 > $DCC_PATH/config
    echo 0x3d8ec54 > $DCC_PATH/config
    echo 0x3d8eca0 > $DCC_PATH/config
    echo 0x3d8ecc0 > $DCC_PATH/config
    echo 0x3d7d018 3 > $DCC_PATH/config
    echo 0x3d7e440 2 > $DCC_PATH/config
    echo 0x3d7e480 2 > $DCC_PATH/config
    echo 0x3d7e490 2 > $DCC_PATH/config
    echo 0x3d7e4a0 2 > $DCC_PATH/config
    echo 0x3d7e4b0 2 > $DCC_PATH/config
    echo 0x3d7e5c0 10 > $DCC_PATH/config
    echo 0x3d7e648 2 > $DCC_PATH/config
    echo 0x3d7e658 9 > $DCC_PATH/config
    echo 0x3d7e7c0 2 > $DCC_PATH/config

}

config_cabo()
{
    echo 0x193d0400 2 > $DCC_PATH/config
    echo 0x193d0410 3 > $DCC_PATH/config
    echo 0x193d0420 2 > $DCC_PATH/config
    echo 0x193d0430 > $DCC_PATH/config
    echo 0x193d0440 > $DCC_PATH/config
    echo 0x193d0448 > $DCC_PATH/config
    echo 0x193d04a0 > $DCC_PATH/config
    echo 0x193d04b0 4 > $DCC_PATH/config
    echo 0x193d04d0 2 > $DCC_PATH/config
    echo 0x193d04e0 > $DCC_PATH/config
    echo 0x192d0400 2 > $DCC_PATH/config
    echo 0x192d0410 3 > $DCC_PATH/config
    echo 0x192d0420 2 > $DCC_PATH/config
    echo 0x192d0430 > $DCC_PATH/config
    echo 0x192d0440 > $DCC_PATH/config
    echo 0x192d0448 > $DCC_PATH/config
    echo 0x192d04a0 > $DCC_PATH/config
    echo 0x192d04b0 4 > $DCC_PATH/config
    echo 0x192d04d0 2 > $DCC_PATH/config
    echo 0x192d04e0 > $DCC_PATH/config
    echo 0x192d1400 2 > $DCC_PATH/config
    echo 0x192d1410 3 > $DCC_PATH/config
    echo 0x192d1420 2 > $DCC_PATH/config
    echo 0x192d1430 > $DCC_PATH/config
    echo 0x192d1440 > $DCC_PATH/config
    echo 0x192d2400 2 > $DCC_PATH/config
    echo 0x192d2410 > $DCC_PATH/config
    echo 0x192d2418 > $DCC_PATH/config
    echo 0x192d3400 5 > $DCC_PATH/config
    echo 0x192d5110 > $DCC_PATH/config
    echo 0x192d5210 > $DCC_PATH/config
    echo 0x192d5230 > $DCC_PATH/config
    echo 0x192d53b0 2 > $DCC_PATH/config
    echo 0x192d5840 > $DCC_PATH/config
    echo 0x192d5920 4 > $DCC_PATH/config
    echo 0x192d5b00 8 > $DCC_PATH/config
    echo 0x192d5b28 5 > $DCC_PATH/config
    echo 0x192d6400 > $DCC_PATH/config
    echo 0x192d6410 > $DCC_PATH/config
    echo 0x192d6418 > $DCC_PATH/config
    echo 0x192d6420 > $DCC_PATH/config
    echo 0x192d9100 > $DCC_PATH/config
}

config_cb()
{
    echo 0xec80010 > $DCC_PATH/config
    echo 0xec81000 > $DCC_PATH/config
    echo 0xec81010 64 > $DCC_PATH/config
    echo 0xec811d0 16 > $DCC_PATH/config
}

config_turing()
{
    echo 0x32310220 3 > $DCC_PATH/config
    echo 0x323102a0 3 > $DCC_PATH/config
    echo 0x323104a0 6 > $DCC_PATH/config
    echo 0x32310520 > $DCC_PATH/config
    echo 0x32310588 > $DCC_PATH/config
    echo 0x32310d10 8 > $DCC_PATH/config
    echo 0x32310f90 6 > $DCC_PATH/config
    echo 0x32311010 6 > $DCC_PATH/config
    echo 0x32311a10 3 > $DCC_PATH/config
    echo 0x323b0228 > $DCC_PATH/config
    echo 0x323b0248 > $DCC_PATH/config
    echo 0x323b0268 > $DCC_PATH/config
    echo 0x323b0288 > $DCC_PATH/config
    echo 0x323b02a8 > $DCC_PATH/config
    echo 0x323b022c > $DCC_PATH/config
    echo 0x323b024c > $DCC_PATH/config
    echo 0x323b026c > $DCC_PATH/config
    echo 0x323b028c > $DCC_PATH/config
    echo 0x323b02ac > $DCC_PATH/config
    echo 0x323b0210 > $DCC_PATH/config
    echo 0x323b0230 > $DCC_PATH/config
    echo 0x323b0250 > $DCC_PATH/config
    echo 0x323b0270 > $DCC_PATH/config
    echo 0x323b0290 > $DCC_PATH/config
    echo 0x323b02b0 > $DCC_PATH/config
    echo 0x323b0400 3 > $DCC_PATH/config
    echo 0x320a4404 > $DCC_PATH/config
    echo 0x32302028 > $DCC_PATH/config
    echo 0x32300304 > $DCC_PATH/config
    echo 0x320a4408 > $DCC_PATH/config
    echo 0x320a4400 > $DCC_PATH/config
    echo 0x320a4208 > $DCC_PATH/config
    echo 0x320b4208 > $DCC_PATH/config
    echo 0x320c4208 > $DCC_PATH/config
    echo 0x320d4208 > $DCC_PATH/config
    echo 0x320a420c > $DCC_PATH/config
    echo 0x320b420c > $DCC_PATH/config
    echo 0x320c420c > $DCC_PATH/config
    echo 0x320d420c > $DCC_PATH/config
    echo 0x320a7d4c > $DCC_PATH/config
    echo 0x323b0208 > $DCC_PATH/config
    echo 0x323c0208 > $DCC_PATH/config
    echo 0x323d0208 > $DCC_PATH/config
    echo 0x323e0208 > $DCC_PATH/config
    echo 0x323b020c > $DCC_PATH/config
    echo 0x323c020c > $DCC_PATH/config
    echo 0x323d020c > $DCC_PATH/config
    echo 0x323e020c > $DCC_PATH/config
    echo 0xb2b1024 > $DCC_PATH/config
    echo 0xb2b4520 > $DCC_PATH/config
    echo 0xb2b1204 > $DCC_PATH/config
    echo 0xb2b1218 > $DCC_PATH/config
    echo 0xb2b122c > $DCC_PATH/config
    echo 0xb2b1240 > $DCC_PATH/config
    echo 0xb2b1208 > $DCC_PATH/config
    echo 0xb2b121c > $DCC_PATH/config
    echo 0xb2b1230 > $DCC_PATH/config
    echo 0xb2b1244 > $DCC_PATH/config
    }

config_lpass()
{
    echo 0x30b0228 > $DCC_PATH/config
    echo 0x30b0248 > $DCC_PATH/config
    echo 0x30b0268 > $DCC_PATH/config
    echo 0x30b0288 > $DCC_PATH/config
    echo 0x30b02a8 > $DCC_PATH/config
    echo 0x30b022c > $DCC_PATH/config
    echo 0x30b024c > $DCC_PATH/config
    echo 0x30b026c > $DCC_PATH/config
    echo 0x30b028c > $DCC_PATH/config
    echo 0x30b02ac > $DCC_PATH/config
    echo 0x30b0210 > $DCC_PATH/config
    echo 0x30b0230 > $DCC_PATH/config
    echo 0x30b0250 > $DCC_PATH/config
    echo 0x30b0270 > $DCC_PATH/config
    echo 0x30b0290 > $DCC_PATH/config
    echo 0x30b02b0 > $DCC_PATH/config
    echo 0x30b0400 3 > $DCC_PATH/config
    echo 0x3480404 > $DCC_PATH/config
    echo 0x3002028 > $DCC_PATH/config
    echo 0x3000304 > $DCC_PATH/config
    echo 0x3480408 > $DCC_PATH/config
    echo 0x3480400 > $DCC_PATH/config
    echo 0x3480208 > $DCC_PATH/config
    echo 0x3490208 > $DCC_PATH/config
    echo 0x3480204 > $DCC_PATH/config
    echo 0x3490204 > $DCC_PATH/config
    echo 0x3483d4c > $DCC_PATH/config
    echo 0x30b0208 > $DCC_PATH/config
    echo 0x30c0208 > $DCC_PATH/config
    echo 0x30d0208 > $DCC_PATH/config
    echo 0x30e0208 > $DCC_PATH/config
    echo 0x30b020c > $DCC_PATH/config
    echo 0x30c020c > $DCC_PATH/config
    echo 0x30d020c > $DCC_PATH/config
    echo 0x30e020c > $DCC_PATH/config
    echo 0xb251024 > $DCC_PATH/config
    echo 0xb254520 > $DCC_PATH/config
    echo 0xb251218 > $DCC_PATH/config
    echo 0xb25122c > $DCC_PATH/config
    echo 0xb251240 > $DCC_PATH/config
    echo 0xb251254 > $DCC_PATH/config
    echo 0xb251208 > $DCC_PATH/config
    echo 0xb25121c > $DCC_PATH/config
    echo 0xb251230 > $DCC_PATH/config
    echo 0xb251244 > $DCC_PATH/config
}

config_modem()
{
    echo 0x4130228 > $DCC_PATH/config
    echo 0x4130248 > $DCC_PATH/config
    echo 0x4130268 > $DCC_PATH/config
    echo 0x4130288 > $DCC_PATH/config
    echo 0x41302a8 > $DCC_PATH/config
    echo 0x413022c > $DCC_PATH/config
    echo 0x413024c > $DCC_PATH/config
    echo 0x413026c > $DCC_PATH/config
    echo 0x413028c > $DCC_PATH/config
    echo 0x41302ac > $DCC_PATH/config
    echo 0x4130210 > $DCC_PATH/config
    echo 0x4130230 > $DCC_PATH/config
    echo 0x4130250 > $DCC_PATH/config
    echo 0x4130270 > $DCC_PATH/config
    echo 0x4130290 > $DCC_PATH/config
    echo 0x41302b0 > $DCC_PATH/config
    echo 0x4130400 3 > $DCC_PATH/config
    echo 0x4200404 > $DCC_PATH/config
    echo 0x4082028 > $DCC_PATH/config
    echo 0x4080304 > $DCC_PATH/config
    echo 0x4200408 > $DCC_PATH/config
    echo 0x4200400 > $DCC_PATH/config
    echo 0x4200208 > $DCC_PATH/config
    echo 0x4210208 > $DCC_PATH/config
    echo 0x4220208 > $DCC_PATH/config
    echo 0x4230208 > $DCC_PATH/config
    echo 0x420020c > $DCC_PATH/config
    echo 0x421020c > $DCC_PATH/config
    echo 0x422020c > $DCC_PATH/config
    echo 0x423020c > $DCC_PATH/config
    echo 0x4203d4c > $DCC_PATH/config
    echo 0x4130208 > $DCC_PATH/config
    echo 0x4140208 > $DCC_PATH/config
    echo 0x4150208 > $DCC_PATH/config
    echo 0x4160208 > $DCC_PATH/config
    echo 0x413020c > $DCC_PATH/config
    echo 0x414020c > $DCC_PATH/config
    echo 0x415020c > $DCC_PATH/config
    echo 0x416020c > $DCC_PATH/config
    echo 0xb2f1024 > $DCC_PATH/config
    echo 0xb2f4520 > $DCC_PATH/config
    echo 0xb2f1204 > $DCC_PATH/config
    echo 0xb2f1218 > $DCC_PATH/config
    echo 0xb2f122c > $DCC_PATH/config
    echo 0xb2f1240 > $DCC_PATH/config
    echo 0xb2f1208 > $DCC_PATH/config
    echo 0xb2f121c > $DCC_PATH/config
    echo 0xb2f1230 > $DCC_PATH/config
    echo 0xb2f1244 > $DCC_PATH/config
}

config_wpss()
{
    echo 0x8ab0208 > $DCC_PATH/config
    echo 0x8ab0228 > $DCC_PATH/config
    echo 0x8ab0248 > $DCC_PATH/config
    echo 0x8ab0268 > $DCC_PATH/config
    echo 0x8ab0288 > $DCC_PATH/config
    echo 0x8ab02a8 > $DCC_PATH/config
    echo 0x8ab020c > $DCC_PATH/config
    echo 0x8ab022c > $DCC_PATH/config
    echo 0x8ab024c > $DCC_PATH/config
    echo 0x8ab026c > $DCC_PATH/config
    echo 0x8ab028c > $DCC_PATH/config
    echo 0x8ab02ac > $DCC_PATH/config
    echo 0x8ab0210 > $DCC_PATH/config
    echo 0x8ab0230 > $DCC_PATH/config
    echo 0x8ab0250 > $DCC_PATH/config
    echo 0x8ab0270 > $DCC_PATH/config
    echo 0x8ab0290 > $DCC_PATH/config
    echo 0x8ab02b0 > $DCC_PATH/config
    echo 0x8ab0400 3 > $DCC_PATH/config
    echo 0x8b00400 3 > $DCC_PATH/config
    echo 0xb2e1024 > $DCC_PATH/config
    echo 0xb2e4520 > $DCC_PATH/config
    echo 0xb2e1204 > $DCC_PATH/config
    echo 0xb2e1218 > $DCC_PATH/config
    echo 0xb2e122c > $DCC_PATH/config
    echo 0xb2e1240 > $DCC_PATH/config
    echo 0xb2e1208 > $DCC_PATH/config
    echo 0xb2e1244 > $DCC_PATH/config
    echo 0xb2e1258 > $DCC_PATH/config
    echo 0xb2e126c > $DCC_PATH/config
}

config_tme()
{
    echo 0x20c200f0 8 > $DCC_PATH/config
    echo 0xb2c1024 > $DCC_PATH/config
    echo 0xb2c4520 > $DCC_PATH/config
    echo 0xb2c1204 > $DCC_PATH/config
    echo 0xb2c1218 > $DCC_PATH/config
    echo 0xb2c122c > $DCC_PATH/config
    echo 0xb2c1240 > $DCC_PATH/config
    echo 0xb2c1208 > $DCC_PATH/config
    echo 0xb2c121c > $DCC_PATH/config
    echo 0xb2c1230 > $DCC_PATH/config
    echo 0xb2c1244 > $DCC_PATH/config
}

config_cam()
{
    echo 0x136010 > $DCC_PATH/config
    echo 0x136018 > $DCC_PATH/config
    echo 0xac4d000 > $DCC_PATH/config
    echo 0xac40000 > $DCC_PATH/config
    echo 0xad150d0 > $DCC_PATH/config
    echo 0xad10060 2 > $DCC_PATH/config
    echo 0xad10044 2 > $DCC_PATH/config
    echo 0xad10004 2 > $DCC_PATH/config
    echo 0xad10018 2 > $DCC_PATH/config
    echo 0xad10030 > $DCC_PATH/config
    echo 0xad10078 > $DCC_PATH/config
    echo 0xad1005c > $DCC_PATH/config
    echo 0xad10000 > $DCC_PATH/config
    echo 0xad10040 > $DCC_PATH/config
    echo 0xad11004 2 > $DCC_PATH/config
    echo 0xad11018 2 > $DCC_PATH/config
    echo 0xad11030 > $DCC_PATH/config
    echo 0xad11048 > $DCC_PATH/config
    echo 0xad11044 > $DCC_PATH/config
    echo 0xad11000 > $DCC_PATH/config
    echo 0xad11040 > $DCC_PATH/config
    echo 0xad15070 3 > $DCC_PATH/config
    echo 0xad1508c > $DCC_PATH/config
    echo 0xad15094 > $DCC_PATH/config
    echo 0xad13090 > $DCC_PATH/config
    echo 0xad13000 > $DCC_PATH/config
    echo 0xad13038 > $DCC_PATH/config
    echo 0xad13008 > $DCC_PATH/config
    echo 0xad13004 > $DCC_PATH/config
    echo 0xad1308c > $DCC_PATH/config
    echo 0xad13030 > $DCC_PATH/config
    echo 0xad13044 > $DCC_PATH/config
    echo 0xad13018 2 > $DCC_PATH/config
    echo 0xad13060 > $DCC_PATH/config
    echo 0xad13048 2 > $DCC_PATH/config
    echo 0xad14000 > $DCC_PATH/config
    echo 0xad14038 > $DCC_PATH/config
    echo 0xad14070 > $DCC_PATH/config
    echo 0xad14008 > $DCC_PATH/config
    echo 0xad14004 > $DCC_PATH/config
    echo 0xad1406c > $DCC_PATH/config
    echo 0xad14060 > $DCC_PATH/config
    echo 0xad14048 2 > $DCC_PATH/config
    echo 0xad14030 > $DCC_PATH/config
    echo 0xad14044 > $DCC_PATH/config
    echo 0xad14018 2 > $DCC_PATH/config
    echo 0xad14074 > $DCC_PATH/config
    echo 0xad140ac > $DCC_PATH/config
    echo 0xad140e0 > $DCC_PATH/config
    echo 0xad1407c > $DCC_PATH/config
    echo 0xad14078 > $DCC_PATH/config
    echo 0xad140dc > $DCC_PATH/config
    echo 0xad140a4 > $DCC_PATH/config
    echo 0xad1408c 2 > $DCC_PATH/config
    echo 0xad140d0 > $DCC_PATH/config
    echo 0xad140b8 2 > $DCC_PATH/config
    echo 0xad15040 2 > $DCC_PATH/config
    echo 0xad15018 > $DCC_PATH/config
    echo 0xad15000 2 > $DCC_PATH/config
    echo 0xad15034 > $DCC_PATH/config
    echo 0xad1501c 2 > $DCC_PATH/config
    echo 0xad150f0 > $DCC_PATH/config
    echo 0xad150d4 2 > $DCC_PATH/config
    echo 0xad15120 2 > $DCC_PATH/config
    echo 0xad15134 > $DCC_PATH/config
    echo 0xad15150 > $DCC_PATH/config
    echo 0xacef054 > $DCC_PATH/config
    echo 0xac1001c > $DCC_PATH/config
}

config_core_hung()
{
    echo 0x17000000 > $DCC_PATH/config
    echo 0x17000008 18 > $DCC_PATH/config
    echo 0x17000054 8 > $DCC_PATH/config
    echo 0x170000f0 3 > $DCC_PATH/config
    echo 0x17000100 2 > $DCC_PATH/config
    echo 0x17008000 5 > $DCC_PATH/config
    echo 0x17600004 > $DCC_PATH/config
    echo 0x17600010 3 > $DCC_PATH/config
    echo 0x17600024 3 > $DCC_PATH/config
    echo 0x17600034 > $DCC_PATH/config
    echo 0x17600040 2 > $DCC_PATH/config
    echo 0x17600050 7 > $DCC_PATH/config
    echo 0x17600070 7 > $DCC_PATH/config
    echo 0x17600094 3 > $DCC_PATH/config
    echo 0x176000a8 11 > $DCC_PATH/config
    echo 0x176000d8 14 > $DCC_PATH/config
    echo 0x17600118 5 > $DCC_PATH/config
    echo 0x17600134 3 > $DCC_PATH/config
    echo 0x17600148 5 > $DCC_PATH/config
    echo 0x17600160 3 > $DCC_PATH/config
    echo 0x17600170 3 > $DCC_PATH/config
    echo 0x17600180 4 > $DCC_PATH/config
    echo 0x17600210 2 > $DCC_PATH/config
    echo 0x17600234 2 > $DCC_PATH/config
    echo 0x17600240 11 > $DCC_PATH/config
    echo 0x176002b4 2 > $DCC_PATH/config
    echo 0x17600404 3 > $DCC_PATH/config
    echo 0x1760041c 3 > $DCC_PATH/config
    echo 0x17600434 > $DCC_PATH/config
    echo 0x1760043c 2 > $DCC_PATH/config
    echo 0x17600460 2 > $DCC_PATH/config
    echo 0x17600470 2 > $DCC_PATH/config
    echo 0x17600480 2 > $DCC_PATH/config
    echo 0x17600490 2 > $DCC_PATH/config
    echo 0x176004a0 2 > $DCC_PATH/config
    echo 0x176004b0 2 > $DCC_PATH/config
    echo 0x176004c0 2 > $DCC_PATH/config
    echo 0x176004d0 2 > $DCC_PATH/config
    echo 0x176004e0 2 > $DCC_PATH/config
    echo 0x176004f0 > $DCC_PATH/config
    echo 0x17600500 13 > $DCC_PATH/config
    echo 0x176009fc > $DCC_PATH/config
    echo 0x17601000 12 > $DCC_PATH/config
    echo 0x17602000 65 > $DCC_PATH/config
    echo 0x17603000 12 > $DCC_PATH/config
    echo 0x17604000 65 > $DCC_PATH/config
    echo 0x17605000 > $DCC_PATH/config
    echo 0x17606000 > $DCC_PATH/config
    echo 0x17607000 > $DCC_PATH/config
    echo 0x17608004 3 > $DCC_PATH/config
    echo 0x17608020 2 > $DCC_PATH/config
    echo 0x1760f000 6 > $DCC_PATH/config
    echo 0x17800000 > $DCC_PATH/config
    echo 0x17800008 18 > $DCC_PATH/config
    echo 0x17800054 8 > $DCC_PATH/config
    echo 0x178000f0 3 > $DCC_PATH/config
    echo 0x17800100 2 > $DCC_PATH/config
    echo 0x17810000 > $DCC_PATH/config
    echo 0x17810008 18 > $DCC_PATH/config
    echo 0x17810054 8 > $DCC_PATH/config
    echo 0x178100f0 3 > $DCC_PATH/config
    echo 0x17810100 2 > $DCC_PATH/config
    echo 0x17820000 > $DCC_PATH/config
    echo 0x17820008 18 > $DCC_PATH/config
    echo 0x17820054 8 > $DCC_PATH/config
    echo 0x178200f0 3 > $DCC_PATH/config
    echo 0x17820100 2 > $DCC_PATH/config
    echo 0x17830000 > $DCC_PATH/config
    echo 0x17830008 18 > $DCC_PATH/config
    echo 0x17830054 8 > $DCC_PATH/config
    echo 0x178300f0 3 > $DCC_PATH/config
    echo 0x17830100 2 > $DCC_PATH/config
    echo 0x17840000 > $DCC_PATH/config
    echo 0x17840008 18 > $DCC_PATH/config
    echo 0x17840054 8 > $DCC_PATH/config
    echo 0x178400f0 3 > $DCC_PATH/config
    echo 0x17840100 2 > $DCC_PATH/config
    echo 0x17848000 5 > $DCC_PATH/config
    echo 0x17850000 > $DCC_PATH/config
    echo 0x17850008 18 > $DCC_PATH/config
    echo 0x17850054 8 > $DCC_PATH/config
    echo 0x178500f0 3 > $DCC_PATH/config
    echo 0x17850100 2 > $DCC_PATH/config
    echo 0x17858000 5 > $DCC_PATH/config
    echo 0x17860000 > $DCC_PATH/config
    echo 0x17860008 18 > $DCC_PATH/config
    echo 0x17860054 8 > $DCC_PATH/config
    echo 0x178600f0 3 > $DCC_PATH/config
    echo 0x17860100 2 > $DCC_PATH/config
    echo 0x17868000 5 > $DCC_PATH/config
    echo 0x17870000 > $DCC_PATH/config
    echo 0x17870008 18 > $DCC_PATH/config
    echo 0x17870054 8 > $DCC_PATH/config
    echo 0x178700f0 3 > $DCC_PATH/config
    echo 0x17870100 2 > $DCC_PATH/config
    echo 0x17878000 5 > $DCC_PATH/config
    echo 0x17880000 > $DCC_PATH/config
    echo 0x17880008 18 > $DCC_PATH/config
    echo 0x17880068 2 > $DCC_PATH/config
    echo 0x178800f0 6 > $DCC_PATH/config
    echo 0x17888000 6 > $DCC_PATH/config
    echo 0x17890000 > $DCC_PATH/config
    echo 0x17890008 18 > $DCC_PATH/config
    echo 0x17890068 2 > $DCC_PATH/config
    echo 0x178900f0 6 > $DCC_PATH/config
    echo 0x17898000 6 > $DCC_PATH/config
    echo 0x178a0000 > $DCC_PATH/config
    echo 0x178a0008 18 > $DCC_PATH/config
    echo 0x178a0054 13 > $DCC_PATH/config
    echo 0x178a0090 116 > $DCC_PATH/config
    echo 0x178c0000 146 > $DCC_PATH/config
    echo 0x178c8000 > $DCC_PATH/config
    echo 0x178c8008 > $DCC_PATH/config
    echo 0x178c8010 > $DCC_PATH/config
    echo 0x178c8018 > $DCC_PATH/config
    echo 0x178c8020 > $DCC_PATH/config
    echo 0x178c8028 > $DCC_PATH/config
    echo 0x178c8030 > $DCC_PATH/config
    echo 0x178c8038 > $DCC_PATH/config
    echo 0x178c8040 > $DCC_PATH/config
    echo 0x178c8048 > $DCC_PATH/config
    echo 0x178c8050 > $DCC_PATH/config
    echo 0x178c8058 > $DCC_PATH/config
    echo 0x178c8060 > $DCC_PATH/config
    echo 0x178c8068 > $DCC_PATH/config
    echo 0x178c8070 > $DCC_PATH/config
    echo 0x178c8078 > $DCC_PATH/config
    echo 0x178c8080 > $DCC_PATH/config
    echo 0x178c8088 > $DCC_PATH/config
    echo 0x178c8090 > $DCC_PATH/config
    echo 0x178c8098 > $DCC_PATH/config
    echo 0x178c80a0 > $DCC_PATH/config
    echo 0x178c80a8 > $DCC_PATH/config
    echo 0x178c80b0 > $DCC_PATH/config
    echo 0x178c80b8 > $DCC_PATH/config
    echo 0x178c80c0 > $DCC_PATH/config
    echo 0x178c80c8 > $DCC_PATH/config
    echo 0x178c80d0 > $DCC_PATH/config
    echo 0x178c80d8 > $DCC_PATH/config
    echo 0x178c80e0 > $DCC_PATH/config
    echo 0x178c80e8 > $DCC_PATH/config
    echo 0x178c80f0 > $DCC_PATH/config
    echo 0x178c80f8 > $DCC_PATH/config
    echo 0x178c8100 > $DCC_PATH/config
    echo 0x178c8108 > $DCC_PATH/config
    echo 0x178c8110 > $DCC_PATH/config
    echo 0x178c8118 > $DCC_PATH/config
    echo 0x178cc000 > $DCC_PATH/config
    echo 0x17a80000 16 > $DCC_PATH/config
    echo 0x17a82000 16 > $DCC_PATH/config
    echo 0x17a84000 16 > $DCC_PATH/config
    echo 0x17a86000 16 > $DCC_PATH/config
    echo 0x17aa0000 44 > $DCC_PATH/config
    echo 0x17aa00fc 20 > $DCC_PATH/config
    echo 0x17aa0200 2 > $DCC_PATH/config
    echo 0x17aa0300 > $DCC_PATH/config
    echo 0x17aa0400 > $DCC_PATH/config
    echo 0x17aa0500 > $DCC_PATH/config
    echo 0x17aa0600 > $DCC_PATH/config
    echo 0x17aa0700 5 > $DCC_PATH/config
    echo 0x17b00000 70 > $DCC_PATH/config
    echo 0x17b70000 3 > $DCC_PATH/config
    echo 0x17b70010 8 > $DCC_PATH/config
    echo 0x17b70090 5 > $DCC_PATH/config
    echo 0x17b70100 > $DCC_PATH/config
    echo 0x17b70110 2 > $DCC_PATH/config
    echo 0x17b70190 > $DCC_PATH/config
    echo 0x17b701a0 2 > $DCC_PATH/config
    echo 0x17b70220 2 > $DCC_PATH/config
    echo 0x17b702a0 2 > $DCC_PATH/config
    echo 0x17b70320 > $DCC_PATH/config
    echo 0x17b70380 > $DCC_PATH/config
    echo 0x17b70390 12 > $DCC_PATH/config
    echo 0x17b70410 > $DCC_PATH/config
    echo 0x17b70420 12 > $DCC_PATH/config
    echo 0x17b704a0 12 > $DCC_PATH/config
    echo 0x17b70520 2 > $DCC_PATH/config
    echo 0x17b70580 6 > $DCC_PATH/config
    echo 0x17b70600 > $DCC_PATH/config
    echo 0x17b70610 12 > $DCC_PATH/config
    echo 0x17b70690 12 > $DCC_PATH/config
    echo 0x17b70710 12 > $DCC_PATH/config
    echo 0x17b70790 12 > $DCC_PATH/config
    echo 0x17b70810 12 > $DCC_PATH/config
    echo 0x17b70890 12 > $DCC_PATH/config
    echo 0x17b70910 12 > $DCC_PATH/config
    echo 0x17b70990 12 > $DCC_PATH/config
    echo 0x17b70a10 12 > $DCC_PATH/config
    echo 0x17b70a90 12 > $DCC_PATH/config
    echo 0x17b70b00 > $DCC_PATH/config
    echo 0x17b70b10 12 > $DCC_PATH/config
    echo 0x17b70b90 12 > $DCC_PATH/config
    echo 0x17b70c10 12 > $DCC_PATH/config
    echo 0x17b70c90 12 > $DCC_PATH/config
    echo 0x17b70d10 12 > $DCC_PATH/config
    echo 0x17b70d90 12 > $DCC_PATH/config
    echo 0x17b70e00 > $DCC_PATH/config
    echo 0x17b70e10 10 > $DCC_PATH/config
    echo 0x17b70e90 10 > $DCC_PATH/config
    echo 0x17b70f10 10 > $DCC_PATH/config
    echo 0x17b70f90 10 > $DCC_PATH/config
    echo 0x17b71010 10 > $DCC_PATH/config
    echo 0x17b71090 10 > $DCC_PATH/config
    echo 0x17b71100 > $DCC_PATH/config
    echo 0x17b71110 8 > $DCC_PATH/config
    echo 0x17b71190 8 > $DCC_PATH/config
    echo 0x17b71210 128 > $DCC_PATH/config
    echo 0x17b71a10 8 > $DCC_PATH/config
    echo 0x17b71a90 8 > $DCC_PATH/config
    echo 0x17b71b00 2 > $DCC_PATH/config
    echo 0x17b71b10 8 > $DCC_PATH/config
    echo 0x17b71b90 5 > $DCC_PATH/config
    echo 0x17b71bb0 8 > $DCC_PATH/config
    echo 0x17b71c30 2 > $DCC_PATH/config
    echo 0x17b71c40 8 > $DCC_PATH/config
    echo 0x17b71cc0 4 > $DCC_PATH/config
    echo 0x17b71d00 11 > $DCC_PATH/config
    echo 0x17b78000 3 > $DCC_PATH/config
    echo 0x17b78010 4 > $DCC_PATH/config
    echo 0x17b78090 5 > $DCC_PATH/config
    echo 0x17b78100 > $DCC_PATH/config
    echo 0x17b78110 2 > $DCC_PATH/config
    echo 0x17b78190 > $DCC_PATH/config
    echo 0x17b781a0 2 > $DCC_PATH/config
    echo 0x17b78220 2 > $DCC_PATH/config
    echo 0x17b782a0 2 > $DCC_PATH/config
    echo 0x17b78320 > $DCC_PATH/config
    echo 0x17b78380 > $DCC_PATH/config
    echo 0x17b78390 12 > $DCC_PATH/config
    echo 0x17b78410 > $DCC_PATH/config
    echo 0x17b78420 12 > $DCC_PATH/config
    echo 0x17b784a0 12 > $DCC_PATH/config
    echo 0x17b78520 2 > $DCC_PATH/config
    echo 0x17b78580 6 > $DCC_PATH/config
    echo 0x17b78600 > $DCC_PATH/config
    echo 0x17b78610 8 > $DCC_PATH/config
    echo 0x17b78690 8 > $DCC_PATH/config
    echo 0x17b78710 8 > $DCC_PATH/config
    echo 0x17b78790 8 > $DCC_PATH/config
    echo 0x17b78810 8 > $DCC_PATH/config
    echo 0x17b78890 8 > $DCC_PATH/config
    echo 0x17b78910 8 > $DCC_PATH/config
    echo 0x17b78990 8 > $DCC_PATH/config
    echo 0x17b78a10 8 > $DCC_PATH/config
    echo 0x17b78a90 8 > $DCC_PATH/config
    echo 0x17b78b00 > $DCC_PATH/config
    echo 0x17b78b10 8 > $DCC_PATH/config
    echo 0x17b78b90 8 > $DCC_PATH/config
    echo 0x17b78c10 8 > $DCC_PATH/config
    echo 0x17b78c90 8 > $DCC_PATH/config
    echo 0x17b78d10 8 > $DCC_PATH/config
    echo 0x17b78d90 8 > $DCC_PATH/config
    echo 0x17b78e00 > $DCC_PATH/config
    echo 0x17b78e10 6 > $DCC_PATH/config
    echo 0x17b78e90 6 > $DCC_PATH/config
    echo 0x17b78f10 6 > $DCC_PATH/config
    echo 0x17b78f90 6 > $DCC_PATH/config
    echo 0x17b79010 6 > $DCC_PATH/config
    echo 0x17b79090 6 > $DCC_PATH/config
    echo 0x17b79100 > $DCC_PATH/config
    echo 0x17b79110 4 > $DCC_PATH/config
    echo 0x17b79190 4 > $DCC_PATH/config
    echo 0x17b79210 64 > $DCC_PATH/config
    echo 0x17b79a10 4 > $DCC_PATH/config
    echo 0x17b79a90 4 > $DCC_PATH/config
    echo 0x17b79b00 2 > $DCC_PATH/config
    echo 0x17b79b10 4 > $DCC_PATH/config
    echo 0x17b79b90 5 > $DCC_PATH/config
    echo 0x17b79bb0 4 > $DCC_PATH/config
    echo 0x17b79c30 2 > $DCC_PATH/config
    echo 0x17b79c40 4 > $DCC_PATH/config
    echo 0x17b79cc0 4 > $DCC_PATH/config
    echo 0x17b79d00 11 > $DCC_PATH/config
    echo 0x17b90000 6 > $DCC_PATH/config
    echo 0x17b90020 5 > $DCC_PATH/config
    echo 0x17b90050 > $DCC_PATH/config
    echo 0x17b90070 > $DCC_PATH/config
    echo 0x17b90080 25 > $DCC_PATH/config
    echo 0x17b90100 > $DCC_PATH/config
    echo 0x17b90120 > $DCC_PATH/config
    echo 0x17b90140 > $DCC_PATH/config
    echo 0x17b90200 12 > $DCC_PATH/config
    echo 0x17b90700 > $DCC_PATH/config
    echo 0x17b9070c 3 > $DCC_PATH/config
    echo 0x17b90780 32 > $DCC_PATH/config
    echo 0x17b90808 > $DCC_PATH/config
    echo 0x17b90c48 > $DCC_PATH/config
    echo 0x17b9080c > $DCC_PATH/config
    echo 0x17b90c4c > $DCC_PATH/config
    echo 0x17b90810 > $DCC_PATH/config
    echo 0x17b90c50 > $DCC_PATH/config
    echo 0x17b90814 > $DCC_PATH/config
    echo 0x17b90c54 > $DCC_PATH/config
    echo 0x17b90818 > $DCC_PATH/config
    echo 0x17b90c58 > $DCC_PATH/config
    echo 0x17b9081c > $DCC_PATH/config
    echo 0x17b90c5c > $DCC_PATH/config
    echo 0x17b90824 > $DCC_PATH/config
    echo 0x17b90c64 > $DCC_PATH/config
    echo 0x17b90828 > $DCC_PATH/config
    echo 0x17b90c68 > $DCC_PATH/config
    echo 0x17b9082c > $DCC_PATH/config
    echo 0x17b90c6c > $DCC_PATH/config
    echo 0x17b90840 > $DCC_PATH/config
    echo 0x17b90c80 > $DCC_PATH/config
    echo 0x17b90844 > $DCC_PATH/config
    echo 0x17b90c84 > $DCC_PATH/config
    echo 0x17b90848 > $DCC_PATH/config
    echo 0x17b90c88 > $DCC_PATH/config
    echo 0x17b9084c > $DCC_PATH/config
    echo 0x17b90c8c > $DCC_PATH/config
    echo 0x17b90850 > $DCC_PATH/config
    echo 0x17b90c90 > $DCC_PATH/config
    echo 0x17b90854 > $DCC_PATH/config
    echo 0x17b90c94 > $DCC_PATH/config
    echo 0x17b90858 > $DCC_PATH/config
    echo 0x17b90c98 > $DCC_PATH/config
    echo 0x17b9085c > $DCC_PATH/config
    echo 0x17b90c9c > $DCC_PATH/config
    echo 0x17b90860 > $DCC_PATH/config
    echo 0x17b90ca0 > $DCC_PATH/config
    echo 0x17b90864 > $DCC_PATH/config
    echo 0x17b90ca4 > $DCC_PATH/config
    echo 0x17b90868 > $DCC_PATH/config
    echo 0x17b90ca8 > $DCC_PATH/config
    echo 0x17b9086c > $DCC_PATH/config
    echo 0x17b90cac > $DCC_PATH/config
    echo 0x17b90870 > $DCC_PATH/config
    echo 0x17b90cb0 > $DCC_PATH/config
    echo 0x17b90874 > $DCC_PATH/config
    echo 0x17b90cb4 > $DCC_PATH/config
    echo 0x17b90878 > $DCC_PATH/config
    echo 0x17b90cb8 > $DCC_PATH/config
    echo 0x17b9087c > $DCC_PATH/config
    echo 0x17b90cbc > $DCC_PATH/config
    echo 0x17b93500 80 > $DCC_PATH/config
    echo 0x17b93a80 3 > $DCC_PATH/config
    echo 0x17b93aa8 50 > $DCC_PATH/config
    echo 0x17b93c00 2 > $DCC_PATH/config
    echo 0x17b93c20 3 > $DCC_PATH/config
    echo 0x17b93c30 8 > $DCC_PATH/config
    echo 0x17b93c60 2 > $DCC_PATH/config
    echo 0x17b93c70 2 > $DCC_PATH/config
    echo 0x17ba0000 6 > $DCC_PATH/config
    echo 0x17ba0020 5 > $DCC_PATH/config
    echo 0x17ba0050 > $DCC_PATH/config
    echo 0x17ba0070 > $DCC_PATH/config
    echo 0x17ba0080 25 > $DCC_PATH/config
    echo 0x17ba0100 > $DCC_PATH/config
    echo 0x17ba0120 > $DCC_PATH/config
    echo 0x17ba0140 > $DCC_PATH/config
    echo 0x17ba0200 8 > $DCC_PATH/config
    echo 0x17ba0700 > $DCC_PATH/config
    echo 0x17ba070c 3 > $DCC_PATH/config
    echo 0x17ba0780 32 > $DCC_PATH/config
    echo 0x17ba0808 > $DCC_PATH/config
    echo 0x17ba0c48 > $DCC_PATH/config
    echo 0x17ba080c > $DCC_PATH/config
    echo 0x17ba0c4c > $DCC_PATH/config
    echo 0x17ba0810 > $DCC_PATH/config
    echo 0x17ba0c50 > $DCC_PATH/config
    echo 0x17ba0814 > $DCC_PATH/config
    echo 0x17ba0c54 > $DCC_PATH/config
    echo 0x17ba0818 > $DCC_PATH/config
    echo 0x17ba0c58 > $DCC_PATH/config
    echo 0x17ba081c > $DCC_PATH/config
    echo 0x17ba0c5c > $DCC_PATH/config
    echo 0x17ba0824 > $DCC_PATH/config
    echo 0x17ba0c64 > $DCC_PATH/config
    echo 0x17ba0828 > $DCC_PATH/config
    echo 0x17ba0c68 > $DCC_PATH/config
    echo 0x17ba082c > $DCC_PATH/config
    echo 0x17ba0c6c > $DCC_PATH/config
    echo 0x17ba0840 > $DCC_PATH/config
    echo 0x17ba0c80 > $DCC_PATH/config
    echo 0x17ba0844 > $DCC_PATH/config
    echo 0x17ba0c84 > $DCC_PATH/config
    echo 0x17ba0848 > $DCC_PATH/config
    echo 0x17ba0c88 > $DCC_PATH/config
    echo 0x17ba084c > $DCC_PATH/config
    echo 0x17ba0c8c > $DCC_PATH/config
    echo 0x17ba0850 > $DCC_PATH/config
    echo 0x17ba0c90 > $DCC_PATH/config
    echo 0x17ba0854 > $DCC_PATH/config
    echo 0x17ba0c94 > $DCC_PATH/config
    echo 0x17ba0858 > $DCC_PATH/config
    echo 0x17ba0c98 > $DCC_PATH/config
    echo 0x17ba085c > $DCC_PATH/config
    echo 0x17ba0c9c > $DCC_PATH/config
    echo 0x17ba0860 > $DCC_PATH/config
    echo 0x17ba0ca0 > $DCC_PATH/config
    echo 0x17ba0864 > $DCC_PATH/config
    echo 0x17ba0ca4 > $DCC_PATH/config
    echo 0x17ba0868 > $DCC_PATH/config
    echo 0x17ba0ca8 > $DCC_PATH/config
    echo 0x17ba086c > $DCC_PATH/config
    echo 0x17ba0cac > $DCC_PATH/config
    echo 0x17ba0870 > $DCC_PATH/config
    echo 0x17ba0cb0 > $DCC_PATH/config
    echo 0x17ba0874 > $DCC_PATH/config
    echo 0x17ba0cb4 > $DCC_PATH/config
    echo 0x17ba0878 > $DCC_PATH/config
    echo 0x17ba0cb8 > $DCC_PATH/config
    echo 0x17ba087c > $DCC_PATH/config
    echo 0x17ba0cbc > $DCC_PATH/config
    echo 0x17ba3500 80 > $DCC_PATH/config
    echo 0x17ba3a80 3 > $DCC_PATH/config
    echo 0x17ba3aa8 50 > $DCC_PATH/config
    echo 0x17ba3c00 2 > $DCC_PATH/config
    echo 0x17ba3c20 3 > $DCC_PATH/config
    echo 0x17ba3c30 8 > $DCC_PATH/config
    echo 0x17ba3c60 2 > $DCC_PATH/config
    echo 0x17ba3c70 2 > $DCC_PATH/config
    echo 0x17d80000 3 > $DCC_PATH/config
    echo 0x17d80010 2 > $DCC_PATH/config
    echo 0x17d80100 256 > $DCC_PATH/config
    echo 0x17d90000 4 > $DCC_PATH/config
    echo 0x17d90014 26 > $DCC_PATH/config
    echo 0x17d90080 5 > $DCC_PATH/config
    echo 0x17d900b0 > $DCC_PATH/config
    echo 0x17d900b8 2 > $DCC_PATH/config
    echo 0x17d900d0 9 > $DCC_PATH/config
    echo 0x17d90100 40 > $DCC_PATH/config
    echo 0x17d90200 40 > $DCC_PATH/config
    echo 0x17d90300 5 > $DCC_PATH/config
    echo 0x17d90320 > $DCC_PATH/config
    echo 0x17d9034c 31 > $DCC_PATH/config
    echo 0x17d903e0 2 > $DCC_PATH/config
    echo 0x17d90404 > $DCC_PATH/config
    echo 0x17d91000 4 > $DCC_PATH/config
    echo 0x17d91014 26 > $DCC_PATH/config
    echo 0x17d91080 8 > $DCC_PATH/config
    echo 0x17d910b0 > $DCC_PATH/config
    echo 0x17d910b8 2 > $DCC_PATH/config
    echo 0x17d910d0 9 > $DCC_PATH/config
    echo 0x17d91100 40 > $DCC_PATH/config
    echo 0x17d91200 40 > $DCC_PATH/config
    echo 0x17d91300 5 > $DCC_PATH/config
    echo 0x17d91320 4 > $DCC_PATH/config
    echo 0x17d9134c 35 > $DCC_PATH/config
    echo 0x17d913e0 5 > $DCC_PATH/config
    echo 0x17d91404 > $DCC_PATH/config
    echo 0x17d92000 4 > $DCC_PATH/config
    echo 0x17d92014 26 > $DCC_PATH/config
    echo 0x17d92080 7 > $DCC_PATH/config
    echo 0x17d920b0 > $DCC_PATH/config
    echo 0x17d920b8 2 > $DCC_PATH/config
    echo 0x17d920d0 9 > $DCC_PATH/config
    echo 0x17d92100 40 > $DCC_PATH/config
    echo 0x17d92200 40 > $DCC_PATH/config
    echo 0x17d92300 5 > $DCC_PATH/config
    echo 0x17d92320 3 > $DCC_PATH/config
    echo 0x17d9234c 34 > $DCC_PATH/config
    echo 0x17d923e0 4 > $DCC_PATH/config
    echo 0x17d92404 > $DCC_PATH/config
    echo 0x17d93000 4 > $DCC_PATH/config
    echo 0x17d93014 26 > $DCC_PATH/config
    echo 0x17d93080 5 > $DCC_PATH/config
    echo 0x17d930b0 > $DCC_PATH/config
    echo 0x17d930b8 2 > $DCC_PATH/config
    echo 0x17d930d0 9 > $DCC_PATH/config
    echo 0x17d93100 40 > $DCC_PATH/config
    echo 0x17d93200 40 > $DCC_PATH/config
    echo 0x17d93300 5 > $DCC_PATH/config
    echo 0x17d93320 > $DCC_PATH/config
    echo 0x17d9334c 32 > $DCC_PATH/config
    echo 0x17d933e0 2 > $DCC_PATH/config
    echo 0x17d93404 > $DCC_PATH/config
    echo 0x17d98000 10 > $DCC_PATH/config
    echo 0x17e00000 > $DCC_PATH/config
    echo 0x17e00008 > $DCC_PATH/config
    echo 0x17e00010 > $DCC_PATH/config
    echo 0x17e00018 > $DCC_PATH/config
    echo 0x17e00020 > $DCC_PATH/config
    echo 0x17e00028 > $DCC_PATH/config
    echo 0x17e00030 > $DCC_PATH/config
    echo 0x17e00038 > $DCC_PATH/config
    echo 0x17e00040 > $DCC_PATH/config
    echo 0x17e00048 > $DCC_PATH/config
    echo 0x17e00050 > $DCC_PATH/config
    echo 0x17e00060 > $DCC_PATH/config
    echo 0x17e10000 > $DCC_PATH/config
    echo 0x17e10008 > $DCC_PATH/config
    echo 0x17e10018 > $DCC_PATH/config
    echo 0x17e10020 > $DCC_PATH/config
    echo 0x17e10030 > $DCC_PATH/config
    echo 0x17e100f0 > $DCC_PATH/config
    echo 0x17e100f8 > $DCC_PATH/config
    echo 0x17e10100 > $DCC_PATH/config
    echo 0x17e11000 > $DCC_PATH/config
    echo 0x17e20000 > $DCC_PATH/config
    echo 0x17e20008 > $DCC_PATH/config
    echo 0x17e20010 > $DCC_PATH/config
    echo 0x17e20018 > $DCC_PATH/config
    echo 0x17e20020 > $DCC_PATH/config
    echo 0x17e20028 > $DCC_PATH/config
    echo 0x17e20030 > $DCC_PATH/config
    echo 0x17e20038 > $DCC_PATH/config
    echo 0x17e20800 > $DCC_PATH/config
    echo 0x17e20808 > $DCC_PATH/config
    echo 0x17e20810 > $DCC_PATH/config
    echo 0x17e20e00 > $DCC_PATH/config
    echo 0x17e20e10 > $DCC_PATH/config
    echo 0x17e20fa8 > $DCC_PATH/config
    echo 0x17e20fbc > $DCC_PATH/config
    echo 0x17e20fc8 > $DCC_PATH/config
    echo 0x17e20fd0 12 > $DCC_PATH/config
    echo 0x17e30000 3 > $DCC_PATH/config
    echo 0x17e30010 6 > $DCC_PATH/config
    echo 0x17e30030 6 > $DCC_PATH/config
    echo 0x17e30050 3 > $DCC_PATH/config
    echo 0x17e30170 2 > $DCC_PATH/config
    echo 0x17e30fb0 2 > $DCC_PATH/config
    echo 0x17e30fc8 14 > $DCC_PATH/config
    echo 0x17e80000 3 > $DCC_PATH/config
    echo 0x17e80010 6 > $DCC_PATH/config
    echo 0x17e80030 6 > $DCC_PATH/config
    echo 0x17e80050 3 > $DCC_PATH/config
    echo 0x17e80170 2 > $DCC_PATH/config
    echo 0x17e80fb0 2 > $DCC_PATH/config
    echo 0x17e80fc8 14 > $DCC_PATH/config
    echo 0x17f80000 3 > $DCC_PATH/config
    echo 0x17f80010 6 > $DCC_PATH/config
    echo 0x17f80030 6 > $DCC_PATH/config
    echo 0x17f80050 3 > $DCC_PATH/config
    echo 0x17f80170 2 > $DCC_PATH/config
    echo 0x17f80fb0 2 > $DCC_PATH/config
    echo 0x17f80fc8 14 > $DCC_PATH/config
    echo 0x18080000 3 > $DCC_PATH/config
    echo 0x18080010 6 > $DCC_PATH/config
    echo 0x18080030 6 > $DCC_PATH/config
    echo 0x18080050 3 > $DCC_PATH/config
    echo 0x18080170 2 > $DCC_PATH/config
    echo 0x18080fb0 2 > $DCC_PATH/config
    echo 0x18080fc8 14 > $DCC_PATH/config
    echo 0x18180000 3 > $DCC_PATH/config
    echo 0x18180010 6 > $DCC_PATH/config
    echo 0x18180030 6 > $DCC_PATH/config
    echo 0x18180050 3 > $DCC_PATH/config
    echo 0x18180170 2 > $DCC_PATH/config
    echo 0x18180fb0 2 > $DCC_PATH/config
    echo 0x18180fc8 14 > $DCC_PATH/config
    echo 0x18280000 3 > $DCC_PATH/config
    echo 0x18280010 6 > $DCC_PATH/config
    echo 0x18280030 6 > $DCC_PATH/config
    echo 0x18280050 3 > $DCC_PATH/config
    echo 0x18280170 2 > $DCC_PATH/config
    echo 0x18280fb0 2 > $DCC_PATH/config
    echo 0x18280fc8 14 > $DCC_PATH/config
    echo 0x18380000 3 > $DCC_PATH/config
    echo 0x18380010 6 > $DCC_PATH/config
    echo 0x18380030 6 > $DCC_PATH/config
    echo 0x18380050 3 > $DCC_PATH/config
    echo 0x18380170 2 > $DCC_PATH/config
    echo 0x18380fb0 2 > $DCC_PATH/config
    echo 0x18380fc8 14 > $DCC_PATH/config
    echo 0x18480000 3 > $DCC_PATH/config
    echo 0x18480010 6 > $DCC_PATH/config
    echo 0x18480030 6 > $DCC_PATH/config
    echo 0x18480050 3 > $DCC_PATH/config
    echo 0x18480170 2 > $DCC_PATH/config
    echo 0x18480fb0 2 > $DCC_PATH/config
    echo 0x18480fc8 14 > $DCC_PATH/config
    echo 0x18580000 3 > $DCC_PATH/config
    echo 0x18580010 6 > $DCC_PATH/config
    echo 0x18580030 6 > $DCC_PATH/config
    echo 0x18580050 3 > $DCC_PATH/config
    echo 0x18580170 2 > $DCC_PATH/config
    echo 0x18580fb0 2 > $DCC_PATH/config
    echo 0x18580fc8 14 > $DCC_PATH/config
    echo 0x17e90000 > $DCC_PATH/config
    echo 0x17e90008 > $DCC_PATH/config
    echo 0x17e90010 > $DCC_PATH/config
    echo 0x17e90018 > $DCC_PATH/config
    echo 0x17e90100 > $DCC_PATH/config
    echo 0x17e90108 > $DCC_PATH/config
    echo 0x17e90110 > $DCC_PATH/config
    echo 0x17e90400 4 > $DCC_PATH/config
    echo 0x17e90480 3 > $DCC_PATH/config
    echo 0x17e90c00 2 > $DCC_PATH/config
    echo 0x17e90c20 2 > $DCC_PATH/config
    echo 0x17e90ce0 > $DCC_PATH/config
    echo 0x17e90e00 3 > $DCC_PATH/config
    echo 0x17e90fa8 2 > $DCC_PATH/config
    echo 0x17e90fbc > $DCC_PATH/config
    echo 0x17e90fcc 2 > $DCC_PATH/config
    echo 0x17e90fe0 8 > $DCC_PATH/config
    echo 0x17eb0000 > $DCC_PATH/config
    echo 0x17eb0010 > $DCC_PATH/config
    echo 0x17f90000 > $DCC_PATH/config
    echo 0x17f90008 > $DCC_PATH/config
    echo 0x17f90010 > $DCC_PATH/config
    echo 0x17f90018 > $DCC_PATH/config
    echo 0x17f90100 > $DCC_PATH/config
    echo 0x17f90108 > $DCC_PATH/config
    echo 0x17f90110 > $DCC_PATH/config
    echo 0x17f90400 4 > $DCC_PATH/config
    echo 0x17f90480 3 > $DCC_PATH/config
    echo 0x17f90c00 2 > $DCC_PATH/config
    echo 0x17f90c20 2 > $DCC_PATH/config
    echo 0x17f90ce0 > $DCC_PATH/config
    echo 0x17f90e00 3 > $DCC_PATH/config
    echo 0x17f90fa8 2 > $DCC_PATH/config
    echo 0x17f90fbc > $DCC_PATH/config
    echo 0x17f90fcc 2 > $DCC_PATH/config
    echo 0x17f90fe0 8 > $DCC_PATH/config
    echo 0x17fb0000 > $DCC_PATH/config
    echo 0x17fb0010 > $DCC_PATH/config
    echo 0x18090000 > $DCC_PATH/config
    echo 0x18090008 > $DCC_PATH/config
    echo 0x18090010 > $DCC_PATH/config
    echo 0x18090018 > $DCC_PATH/config
    echo 0x18090100 > $DCC_PATH/config
    echo 0x18090108 > $DCC_PATH/config
    echo 0x18090110 > $DCC_PATH/config
    echo 0x18090400 4 > $DCC_PATH/config
    echo 0x18090480 3 > $DCC_PATH/config
    echo 0x18090c00 2 > $DCC_PATH/config
    echo 0x18090c20 2 > $DCC_PATH/config
    echo 0x18090ce0 > $DCC_PATH/config
    echo 0x18090e00 3 > $DCC_PATH/config
    echo 0x18090fa8 2 > $DCC_PATH/config
    echo 0x18090fbc > $DCC_PATH/config
    echo 0x18090fcc 2 > $DCC_PATH/config
    echo 0x18090fe0 8 > $DCC_PATH/config
    echo 0x180b0000 > $DCC_PATH/config
    echo 0x180b0010 > $DCC_PATH/config
    echo 0x18190000 > $DCC_PATH/config
    echo 0x18190008 > $DCC_PATH/config
    echo 0x18190010 > $DCC_PATH/config
    echo 0x18190018 > $DCC_PATH/config
    echo 0x18190100 > $DCC_PATH/config
    echo 0x18190108 > $DCC_PATH/config
    echo 0x18190110 > $DCC_PATH/config
    echo 0x18190400 4 > $DCC_PATH/config
    echo 0x18190480 3 > $DCC_PATH/config
    echo 0x18190c00 2 > $DCC_PATH/config
    echo 0x18190c20 2 > $DCC_PATH/config
    echo 0x18190ce0 > $DCC_PATH/config
    echo 0x18190e00 3 > $DCC_PATH/config
    echo 0x18190fa8 2 > $DCC_PATH/config
    echo 0x18190fbc > $DCC_PATH/config
    echo 0x18190fcc 2 > $DCC_PATH/config
    echo 0x18190fe0 8 > $DCC_PATH/config
    echo 0x181b0000 > $DCC_PATH/config
    echo 0x181b0010 > $DCC_PATH/config
    echo 0x18290000 > $DCC_PATH/config
    echo 0x18290008 > $DCC_PATH/config
    echo 0x18290010 > $DCC_PATH/config
    echo 0x18290018 > $DCC_PATH/config
    echo 0x18290100 > $DCC_PATH/config
    echo 0x18290108 > $DCC_PATH/config
    echo 0x18290110 > $DCC_PATH/config
    echo 0x18290400 4 > $DCC_PATH/config
    echo 0x18290480 4 > $DCC_PATH/config
    echo 0x18290c00 2 > $DCC_PATH/config
    echo 0x18290c20 2 > $DCC_PATH/config
    echo 0x18290ce0 > $DCC_PATH/config
    echo 0x18290e00 3 > $DCC_PATH/config
    echo 0x18290fa8 2 > $DCC_PATH/config
    echo 0x18290fbc > $DCC_PATH/config
    echo 0x18290fcc 2 > $DCC_PATH/config
    echo 0x18290fe0 8 > $DCC_PATH/config
    echo 0x18390000 > $DCC_PATH/config
    echo 0x18390008 > $DCC_PATH/config
    echo 0x18390010 > $DCC_PATH/config
    echo 0x18390018 > $DCC_PATH/config
    echo 0x18390100 > $DCC_PATH/config
    echo 0x18390108 > $DCC_PATH/config
    echo 0x18390110 > $DCC_PATH/config
    echo 0x18390400 4 > $DCC_PATH/config
    echo 0x18390480 4 > $DCC_PATH/config
    echo 0x18390c00 2 > $DCC_PATH/config
    echo 0x18390c20 2 > $DCC_PATH/config
    echo 0x18390ce0 > $DCC_PATH/config
    echo 0x18390e00 3 > $DCC_PATH/config
    echo 0x18390fa8 2 > $DCC_PATH/config
    echo 0x18390fbc > $DCC_PATH/config
    echo 0x18390fcc 2 > $DCC_PATH/config
    echo 0x18390fe0 8 > $DCC_PATH/config
    echo 0x18490000 > $DCC_PATH/config
    echo 0x18490008 > $DCC_PATH/config
    echo 0x18490010 > $DCC_PATH/config
    echo 0x18490018 > $DCC_PATH/config
    echo 0x18490100 > $DCC_PATH/config
    echo 0x18490108 > $DCC_PATH/config
    echo 0x18490110 > $DCC_PATH/config
    echo 0x18490400 4 > $DCC_PATH/config
    echo 0x18490480 4 > $DCC_PATH/config
    echo 0x18490c00 2 > $DCC_PATH/config
    echo 0x18490c20 2 > $DCC_PATH/config
    echo 0x18490ce0 > $DCC_PATH/config
    echo 0x18490e00 3 > $DCC_PATH/config
    echo 0x18490fa8 2 > $DCC_PATH/config
    echo 0x18490fbc > $DCC_PATH/config
    echo 0x18490fcc 2 > $DCC_PATH/config
    echo 0x18490fe0 8 > $DCC_PATH/config
    echo 0x18590000 > $DCC_PATH/config
    echo 0x18590008 > $DCC_PATH/config
    echo 0x18590010 > $DCC_PATH/config
    echo 0x18590018 > $DCC_PATH/config
    echo 0x18590100 > $DCC_PATH/config
    echo 0x18590108 > $DCC_PATH/config
    echo 0x18590110 > $DCC_PATH/config
    echo 0x18590400 4 > $DCC_PATH/config
    echo 0x18590480 4 > $DCC_PATH/config
    echo 0x18590c00 2 > $DCC_PATH/config
    echo 0x18590c20 2 > $DCC_PATH/config
    echo 0x18590ce0 > $DCC_PATH/config
    echo 0x18590e00 3 > $DCC_PATH/config
    echo 0x18590fa8 2 > $DCC_PATH/config
    echo 0x18590fbc > $DCC_PATH/config
    echo 0x18590fcc 2 > $DCC_PATH/config
    echo 0x18590fe0 8 > $DCC_PATH/config
    echo 0x17a90000 23 > $DCC_PATH/config
    echo 0x17a90080 9 > $DCC_PATH/config
    echo 0x17a900ac 2 > $DCC_PATH/config
    echo 0x17a90100 > $DCC_PATH/config
    echo 0x17a92000 23 > $DCC_PATH/config
    echo 0x17a92080 9 > $DCC_PATH/config
    echo 0x17a920ac 2 > $DCC_PATH/config
    echo 0x17a92100 > $DCC_PATH/config
    echo 0x17a94000 23 > $DCC_PATH/config
    echo 0x17a94080 9 > $DCC_PATH/config
    echo 0x17a940ac 2 > $DCC_PATH/config
    echo 0x17a94100 > $DCC_PATH/config
    echo 0x17a96000 23 > $DCC_PATH/config
    echo 0x17a96080 9 > $DCC_PATH/config
    echo 0x17a960ac 2 > $DCC_PATH/config
}

config_spmi()
{
    echo 0xc42f000 > $DCC_PATH/config
    echo 0xc42c02c > $DCC_PATH/config
    echo 0xc42e804 > $DCC_PATH/config
    echo 0xc42e85c > $DCC_PATH/config
    echo 0xc2a8174 6 > $DCC_PATH/config
}

config_cbcr()
{
    echo 0x193008 > $DCC_PATH/config
    echo 0x193140 > $DCC_PATH/config
    echo 0x193004 > $DCC_PATH/config
    echo 0x120024 > $DCC_PATH/config
    echo 0x12C018 > $DCC_PATH/config
    echo 0x12C020 > $DCC_PATH/config
    echo 0x12C028 > $DCC_PATH/config
    echo 0x12C030 > $DCC_PATH/config
    echo 0x12C038 > $DCC_PATH/config
    echo 0x12C040 > $DCC_PATH/config
    echo 0x157008 > $DCC_PATH/config
    echo 0x17B090 > $DCC_PATH/config
    echo 0x1A0004 > $DCC_PATH/config
    echo 0x1A000C > $DCC_PATH/config
    echo 0x1A0014 > $DCC_PATH/config
    echo 0x1A9014 > $DCC_PATH/config
    echo 0x1A901C > $DCC_PATH/config
}

config_apps_smmu()
{
    echo 0x15000800 159 > $DCC_PATH/config
    echo 0x15000C00 159 > $DCC_PATH/config
    echo 0x15001000 95 > $DCC_PATH/config
}

enable_dcc()
{
    #TODO: Add DCC configuration

    DCC_PATH="/sys/bus/platform/devices/100ff000.dcc_v2"
    soc_version=`cat /sys/devices/soc0/revision`
    soc_version=${soc_version/./}

    if [ ! -d $DCC_PATH ]; then
        echo "DCC does not exist on this build."
        return
    fi

    echo 0 > $DCC_PATH/enable
    echo 1 > $DCC_PATH/config_reset
    echo 6 > $DCC_PATH/curr_list
    echo cap > $DCC_PATH/func_type
    echo sram > $DCC_PATH/data_sink
    config_dcc_tsens
    #config_apss_pwr_state
    config_dcc_core
    #config_smmu

    gemnoc_dump
    config_gpu
    config_dcc_ddr
    config_adsp
    config_core_hung

    echo 4 > $DCC_PATH/curr_list
    echo cap > $DCC_PATH/func_type
    echo sram > $DCC_PATH/data_sink
    dc_noc_dump
    lpass_ag_noc_dump
    lpass_qdsp_dump
    mmss_noc_dump
    system_noc_dump
    aggre_noc_dump
    config_noc_dump

    config_dcc_gic
    config_dcc_rpmh
    config_dcc_apss_rscc
    config_dcc_misc
    config_dcc_gict
    config_cabo
    config_cb
    config_turing
    config_lpass
    config_modem
    config_wpss
    config_tme
    config_cam
    config_spmi
    config_cbcr
    config_apps_smmu

    #config_confignoc
    #enable_dcc_pll_status


    echo  1 > $DCC_PATH/enable
}

##################################
# ACTPM trace API - usage example
##################################

actpm_traces_configure()
{
  echo ++++++++++++++++++++++++++++++++++++++
  echo actpm_traces_configure
  echo ++++++++++++++++++++++++++++++++++++++

  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-actpm/reset
  ### CMB_MSR : [10]: debug_en, [7:6] : 0x0-0x3 : clkdom0-clkdom3 debug_bus
  ###         : [5]: trace_en, [4]: 0b0:continuous mode 0b1 : legacy mode
  ###         : [3:0] : legacy mode : 0x0 : combined_traces 0x1-0x4 : clkdom0-clkdom3
  echo 0 0x420 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_msr
  echo 0 > /sys/bus/coresight/devices/coresight-tpdm-actpm/mcmb_lanes_select
  echo 1 0 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_mode
  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_ts_all
  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_patt_ts
  echo 0 0x20000000 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_patt_mask
  echo 0 0x20000000 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_patt_val

}

actpm_traces_start()
{
  echo ++++++++++++++++++++++++++++++++++++++
  echo actpm_traces_start
  echo ++++++++++++++++++++++++++++++++++++++
  # "Start actpm Trace collection "
  echo 0x4 > /sys/bus/coresight/devices/coresight-tpdm-actpm/enable_datasets
  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-actpm/enable_source
}

stm_traces_configure()
{
  echo ++++++++++++++++++++++++++++++++++++++
  echo stm_traces_configure
  echo ++++++++++++++++++++++++++++++++++++++
  echo 0 > /sys/bus/coresight/devices/coresight-stm/hwevent_enable
}

stm_traces_start()
{
  echo ++++++++++++++++++++++++++++++++++++++
  echo stm_traces_start
  echo ++++++++++++++++++++++++++++++++++++++
  echo 1 > /sys/bus/coresight/devices/coresight-stm/enable_source
}

ipm_traces_configure()
{
  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss/reset
  echo 0x0 0x3f 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
  echo 0x0 0x3f 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
  #gic HW events
  echo 0xfb 0xfc 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
  echo 0xfb 0xfc 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
  echo 0 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
  echo 1 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
  echo 2 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
  echo 3 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
  echo 4 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
  echo 5 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
  echo 6 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
  echo 7 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_ts
  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_type
  echo 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_trig_ts
  echo 0 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
  echo 1 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
  echo 2 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
  echo 3 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
  echo 4 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
  echo 5 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
  echo 6 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
  echo 7 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask

  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/reset
  echo 0x0 0x2 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_edge_ctrl_mask
  echo 0x0 0x2 0 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_edge_ctrl
  echo 0x8a 0x8b 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_edge_ctrl_mask
  echo 0x8a 0x8b 0 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_edge_ctrl
  echo 0xb8 0xca 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_edge_ctrl_mask
  echo 0xb8 0xca 0 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_edge_ctrl
  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_patt_ts
  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_patt_type
  echo 0 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_trig_ts
  echo 0 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_patt_mask
  echo 1 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_patt_mask
  echo 2 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_patt_mask
  echo 3 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_patt_mask
  echo 4 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_patt_mask
  echo 5 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_patt_mask
  echo 6 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_patt_mask
  echo 7 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_patt_mask

}

ipm_traces_start()
{
  # "Start ipm Trace collection "
  echo 2 > /sys/bus/coresight/devices/coresight-tpdm-apss/enable_datasets
  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss/enable_source
  echo 2 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/enable_datasets
  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/enable_source

}

enable_cpuss_hw_events()
{
    actpm_traces_configure
    ipm_traces_configure
    stm_traces_configure

    ipm_traces_start
    stm_traces_start
    actpm_traces_start
}

enable_core_hang_config()
{
    CORE_PATH="/sys/devices/system/cpu/hang_detect_core"
    if [ ! -d $CORE_PATH ]; then
        echo "CORE hang does not exist on this build."
        return
    fi

    #set the threshold to max
    echo 0xffffffff > $CORE_PATH/threshold

    #To enable core hang detection
    #It's a boolean variable. Do not use Hex value to enable/disable
    echo 1 > $CORE_PATH/enable
}

adjust_permission()
{
    #add permission for block_size, mem_type, mem_size nodes to collect diag over QDSS by ODL
    #application by "oem_2902" group
    chown -h root.oem_2902 /sys/devices/platform/soc/10048000.tmc/coresight-tmc-etr/block_size
    chmod 660 /sys/devices/platform/soc/10048000.tmc/coresight-tmc-etr/block_size
    chown -h root.oem_2902 /sys/devices/platform/soc/10048000.tmc/coresight-tmc-etr/buffer_size
    chmod 660 /sys/devices/platform/soc/10048000.tmc/coresight-tmc-etr/buffer_size
}

enable_schedstats()
{
    # bail out if its perf config
    if [ ! -d /sys/module/msm_rtb ]
    then
        return
    fi

    if [ -f /proc/sys/kernel/sched_schedstats ]
    then
        echo 1 > /proc/sys/kernel/sched_schedstats
    fi
}

enable_cpuss_register()
{
    echo 1 > /sys/bus/platform/devices/soc:mem_dump/register_reset

    format_ver=1
    if [ -r /sys/bus/platform/devices/soc:mem_dump/format_version ]; then
        format_ver=$(cat /sys/bus/platform/devices/soc:mem_dump/format_version)
    fi

    echo 0x17000000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17000008 72 > $MEM_DUMP_PATH/register_config
    echo 0x17000054 32 > $MEM_DUMP_PATH/register_config
    echo 0x170000f0 12 > $MEM_DUMP_PATH/register_config
    echo 0x17000100 8 > $MEM_DUMP_PATH/register_config
    echo 0x17008000 20 > $MEM_DUMP_PATH/register_config
    echo 0x17100000 16 > $MEM_DUMP_PATH/register_config
    echo 0x17100020 8 > $MEM_DUMP_PATH/register_config
    echo 0x17100030 4 > $MEM_DUMP_PATH/register_config
    echo 0x17100084 116 > $MEM_DUMP_PATH/register_config
    echo 0x17100104 116 > $MEM_DUMP_PATH/register_config
    echo 0x17100184 116 > $MEM_DUMP_PATH/register_config
    echo 0x17100204 116 > $MEM_DUMP_PATH/register_config
    echo 0x17100284 116 > $MEM_DUMP_PATH/register_config
    echo 0x17100304 116 > $MEM_DUMP_PATH/register_config
    echo 0x17100384 116 > $MEM_DUMP_PATH/register_config
    echo 0x17100420 928 > $MEM_DUMP_PATH/register_config
    echo 0x17100c08 232 > $MEM_DUMP_PATH/register_config
    echo 0x17100d04 116 > $MEM_DUMP_PATH/register_config
    echo 0x17100e08 232 > $MEM_DUMP_PATH/register_config
    echo 0x17106100 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106108 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106110 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106118 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106120 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106128 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106130 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106138 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106140 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106148 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106150 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106158 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106160 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106168 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106170 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106178 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106180 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106188 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106190 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106198 4 > $MEM_DUMP_PATH/register_config
    echo 0x171061a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171061a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171061b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171061b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171061c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171061c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171061d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171061d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171061e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171061e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171061f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171061f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106200 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106208 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106210 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106218 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106220 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106228 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106230 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106238 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106240 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106248 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106250 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106258 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106260 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106268 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106270 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106278 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106280 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106288 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106290 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106298 4 > $MEM_DUMP_PATH/register_config
    echo 0x171062a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171062a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171062b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171062b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171062c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171062c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171062d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171062d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171062e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171062e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171062f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171062f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106300 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106308 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106310 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106318 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106320 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106328 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106330 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106338 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106340 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106348 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106350 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106358 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106360 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106368 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106370 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106378 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106380 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106388 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106390 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106398 4 > $MEM_DUMP_PATH/register_config
    echo 0x171063a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171063a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171063b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171063b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171063c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171063c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171063d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171063d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171063e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171063e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171063f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171063f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106400 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106408 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106410 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106418 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106420 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106428 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106430 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106438 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106440 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106448 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106450 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106458 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106460 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106468 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106470 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106478 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106480 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106488 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106490 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106498 4 > $MEM_DUMP_PATH/register_config
    echo 0x171064a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171064a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171064b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171064b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171064c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171064c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171064d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171064d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171064e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171064e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171064f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171064f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106500 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106508 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106510 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106518 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106520 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106528 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106530 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106538 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106540 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106548 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106550 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106558 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106560 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106568 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106570 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106578 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106580 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106588 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106590 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106598 4 > $MEM_DUMP_PATH/register_config
    echo 0x171065a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171065a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171065b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171065b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171065c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171065c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171065d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171065d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171065e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171065e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171065f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171065f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106600 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106608 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106610 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106618 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106620 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106628 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106630 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106638 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106640 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106648 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106650 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106658 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106660 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106668 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106670 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106678 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106680 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106688 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106690 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106698 4 > $MEM_DUMP_PATH/register_config
    echo 0x171066a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171066a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171066b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171066b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171066c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171066c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171066d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171066d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171066e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171066e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171066f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171066f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106700 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106708 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106710 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106718 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106720 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106728 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106730 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106738 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106740 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106748 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106750 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106758 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106760 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106768 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106770 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106778 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106780 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106788 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106790 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106798 4 > $MEM_DUMP_PATH/register_config
    echo 0x171067a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171067a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171067b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171067b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171067c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171067c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171067d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171067d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171067e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171067e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171067f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171067f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106800 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106808 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106810 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106818 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106820 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106828 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106830 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106838 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106840 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106848 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106850 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106858 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106860 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106868 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106870 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106878 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106880 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106888 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106890 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106898 4 > $MEM_DUMP_PATH/register_config
    echo 0x171068a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171068a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171068b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171068b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171068c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171068c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171068d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171068d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171068e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171068e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171068f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171068f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106900 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106908 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106910 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106918 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106920 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106928 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106930 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106938 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106940 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106948 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106950 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106958 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106960 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106968 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106970 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106978 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106980 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106988 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106990 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106998 4 > $MEM_DUMP_PATH/register_config
    echo 0x171069a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171069a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171069b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171069b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171069c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171069c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171069d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171069d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171069e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171069e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171069f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171069f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106a00 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106a08 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106a10 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106a18 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106a20 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106a28 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106a30 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106a38 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106a40 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106a48 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106a50 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106a58 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106a60 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106a68 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106a70 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106a78 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106a80 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106a88 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106a90 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106a98 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106aa0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106aa8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ab0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ab8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ac0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ac8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ad0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ad8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ae0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ae8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106af0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106af8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106b00 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106b08 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106b10 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106b18 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106b20 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106b28 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106b30 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106b38 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106b40 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106b48 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106b50 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106b58 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106b60 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106b68 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106b70 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106b78 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106b80 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106b88 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106b90 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106b98 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ba0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ba8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106bb0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106bb8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106bc0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106bc8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106bd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106bd8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106be0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106be8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106bf0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106bf8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106c00 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106c08 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106c10 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106c18 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106c20 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106c28 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106c30 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106c38 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106c40 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106c48 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106c50 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106c58 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106c60 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106c68 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106c70 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106c78 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106c80 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106c88 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106c90 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106c98 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ca0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ca8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106cb0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106cb8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106cc0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106cc8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106cd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106cd8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ce0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ce8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106cf0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106cf8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106d00 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106d08 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106d10 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106d18 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106d20 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106d28 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106d30 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106d38 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106d40 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106d48 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106d50 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106d58 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106d60 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106d68 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106d70 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106d78 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106d80 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106d88 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106d90 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106d98 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106da0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106da8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106db0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106db8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106dc0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106dc8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106dd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106dd8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106de0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106de8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106df0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106df8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106e00 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106e08 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106e10 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106e18 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106e20 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106e28 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106e30 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106e38 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106e40 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106e48 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106e50 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106e58 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106e60 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106e68 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106e70 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106e78 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106e80 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106e88 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106e90 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106e98 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ea0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ea8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106eb0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106eb8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ec0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ec8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ed0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ed8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ee0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ee8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ef0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ef8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106f00 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106f08 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106f10 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106f18 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106f20 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106f28 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106f30 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106f38 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106f40 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106f48 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106f50 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106f58 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106f60 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106f68 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106f70 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106f78 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106f80 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106f88 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106f90 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106f98 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106fa0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106fa8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106fb0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106fb8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106fc0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106fc8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106fd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106fd8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106fe0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106fe8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ff0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17106ff8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107008 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107010 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107018 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107020 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107028 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107030 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107038 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107040 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107048 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107050 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107058 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107060 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107068 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107070 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107078 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107080 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107088 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107090 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107098 4 > $MEM_DUMP_PATH/register_config
    echo 0x171070a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171070a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171070b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171070b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171070c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171070c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171070d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171070d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171070e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171070e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171070f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171070f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107100 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107108 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107110 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107118 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107120 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107128 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107130 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107138 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107140 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107148 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107150 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107158 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107160 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107168 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107170 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107178 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107180 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107188 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107190 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107198 4 > $MEM_DUMP_PATH/register_config
    echo 0x171071a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171071a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171071b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171071b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171071c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171071c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171071d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171071d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171071e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171071e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171071f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171071f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107200 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107208 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107210 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107218 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107220 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107228 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107230 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107238 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107240 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107248 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107250 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107258 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107260 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107268 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107270 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107278 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107280 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107288 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107290 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107298 4 > $MEM_DUMP_PATH/register_config
    echo 0x171072a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171072a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171072b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171072b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171072c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171072c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171072d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171072d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171072e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171072e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171072f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171072f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107300 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107308 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107310 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107318 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107320 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107328 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107330 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107338 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107340 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107348 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107350 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107358 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107360 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107368 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107370 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107378 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107380 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107388 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107390 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107398 4 > $MEM_DUMP_PATH/register_config
    echo 0x171073a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171073a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171073b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171073b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171073c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171073c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171073d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171073d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171073e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171073e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171073f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171073f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107400 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107408 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107410 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107418 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107420 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107428 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107430 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107438 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107440 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107448 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107450 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107458 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107460 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107468 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107470 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107478 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107480 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107488 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107490 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107498 4 > $MEM_DUMP_PATH/register_config
    echo 0x171074a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171074a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171074b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171074b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171074c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171074c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171074d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171074d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171074e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171074e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171074f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171074f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107500 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107508 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107510 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107518 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107520 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107528 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107530 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107538 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107540 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107548 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107550 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107558 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107560 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107568 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107570 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107578 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107580 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107588 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107590 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107598 4 > $MEM_DUMP_PATH/register_config
    echo 0x171075a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171075a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171075b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171075b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171075c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171075c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171075d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171075d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171075e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171075e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171075f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171075f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107600 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107608 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107610 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107618 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107620 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107628 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107630 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107638 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107640 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107648 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107650 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107658 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107660 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107668 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107670 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107678 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107680 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107688 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107690 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107698 4 > $MEM_DUMP_PATH/register_config
    echo 0x171076a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171076a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171076b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171076b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171076c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171076c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171076d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171076d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171076e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171076e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171076f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171076f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107700 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107708 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107710 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107718 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107720 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107728 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107730 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107738 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107740 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107748 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107750 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107758 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107760 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107768 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107770 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107778 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107780 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107788 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107790 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107798 4 > $MEM_DUMP_PATH/register_config
    echo 0x171077a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171077a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171077b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171077b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171077c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171077c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171077d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171077d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171077e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171077e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171077f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171077f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107800 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107808 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107810 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107818 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107820 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107828 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107830 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107838 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107840 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107848 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107850 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107858 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107860 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107868 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107870 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107878 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107880 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107888 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107890 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107898 4 > $MEM_DUMP_PATH/register_config
    echo 0x171078a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171078a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171078b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171078b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171078c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171078c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171078d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171078d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171078e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171078e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171078f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171078f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107900 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107908 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107910 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107918 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107920 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107928 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107930 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107938 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107940 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107948 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107950 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107958 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107960 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107968 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107970 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107978 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107980 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107988 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107990 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107998 4 > $MEM_DUMP_PATH/register_config
    echo 0x171079a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171079a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171079b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171079b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171079c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171079c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171079d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171079d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171079e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171079e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171079f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171079f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107a00 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107a08 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107a10 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107a18 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107a20 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107a28 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107a30 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107a38 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107a40 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107a48 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107a50 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107a58 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107a60 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107a68 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107a70 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107a78 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107a80 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107a88 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107a90 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107a98 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107aa0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107aa8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107ab0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107ab8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107ac0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107ac8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107ad0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107ad8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107ae0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107ae8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107af0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107af8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107b00 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107b08 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107b10 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107b18 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107b20 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107b28 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107b30 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107b38 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107b40 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107b48 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107b50 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107b58 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107b60 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107b68 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107b70 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107b78 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107b80 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107b88 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107b90 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107b98 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107ba0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107ba8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107bb0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107bb8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107bc0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107bc8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107bd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107bd8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107be0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107be8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107bf0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107bf8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107c00 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107c08 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107c10 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107c18 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107c20 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107c28 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107c30 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107c38 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107c40 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107c48 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107c50 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107c58 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107c60 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107c68 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107c70 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107c78 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107c80 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107c88 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107c90 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107c98 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107ca0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107ca8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107cb0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107cb8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107cc0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107cc8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107cd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107cd8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107ce0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107ce8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107cf0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107cf8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107d00 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107d08 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107d10 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107d18 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107d20 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107d28 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107d30 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107d38 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107d40 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107d48 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107d50 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107d58 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107d60 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107d68 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107d70 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107d78 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107d80 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107d88 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107d90 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107d98 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107da0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107da8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107db0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107db8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107dc0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107dc8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107dd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107dd8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107de0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107de8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107df0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17107df8 4 > $MEM_DUMP_PATH/register_config
    echo 0x1710e008 232 > $MEM_DUMP_PATH/register_config
    echo 0x1710e104 116 > $MEM_DUMP_PATH/register_config
    echo 0x1710e184 116 > $MEM_DUMP_PATH/register_config
    echo 0x1710e204 116 > $MEM_DUMP_PATH/register_config
    echo 0x1710ea00 4 > $MEM_DUMP_PATH/register_config
    echo 0x1710ea08 4 > $MEM_DUMP_PATH/register_config
    echo 0x1710ea10 4 > $MEM_DUMP_PATH/register_config
    echo 0x1710ea18 4 > $MEM_DUMP_PATH/register_config
    echo 0x1710ea20 4 > $MEM_DUMP_PATH/register_config
    echo 0x1710ea28 4 > $MEM_DUMP_PATH/register_config
    echo 0x1710ea30 4 > $MEM_DUMP_PATH/register_config
    echo 0x1710ea38 4 > $MEM_DUMP_PATH/register_config
    echo 0x1710ea40 4 > $MEM_DUMP_PATH/register_config
    echo 0x1710ea48 4 > $MEM_DUMP_PATH/register_config
    echo 0x1710ea50 4 > $MEM_DUMP_PATH/register_config
    echo 0x1710ea58 4 > $MEM_DUMP_PATH/register_config
    echo 0x1710ea60 4 > $MEM_DUMP_PATH/register_config
    echo 0x1710ea68 4 > $MEM_DUMP_PATH/register_config
    echo 0x1710ea70 4 > $MEM_DUMP_PATH/register_config
    echo 0x1710f000 4 > $MEM_DUMP_PATH/register_config
    echo 0x1710ffd0 48 > $MEM_DUMP_PATH/register_config
    echo 0x17120000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120008 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120010 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120018 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120020 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120028 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120040 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120048 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120050 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120058 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120060 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120068 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120080 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120088 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120090 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120098 4 > $MEM_DUMP_PATH/register_config
    echo 0x171200a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171200a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171200c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171200c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171200d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171200d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171200e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171200e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120100 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120108 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120110 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120118 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120120 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120128 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120140 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120148 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120150 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120158 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120160 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120168 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120180 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120188 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120190 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120198 4 > $MEM_DUMP_PATH/register_config
    echo 0x171201a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171201a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171201c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171201c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171201d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171201d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171201e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171201e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120200 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120208 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120210 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120218 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120220 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120228 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120240 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120248 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120250 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120258 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120260 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120268 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120280 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120288 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120290 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120298 4 > $MEM_DUMP_PATH/register_config
    echo 0x171202a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171202a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171202c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171202c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171202d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171202d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171202e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171202e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120300 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120308 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120310 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120318 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120320 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120328 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120340 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120348 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120350 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120358 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120360 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120368 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120380 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120388 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120390 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120398 4 > $MEM_DUMP_PATH/register_config
    echo 0x171203a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171203a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171203c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171203c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171203d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171203d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171203e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171203e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120400 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120408 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120410 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120418 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120420 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120428 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120440 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120448 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120450 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120458 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120460 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120468 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120480 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120488 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120490 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120498 4 > $MEM_DUMP_PATH/register_config
    echo 0x171204a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171204a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171204c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171204c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171204d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171204d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171204e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171204e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120500 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120508 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120510 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120518 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120520 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120528 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120540 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120548 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120550 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120558 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120560 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120568 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120580 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120588 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120590 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120598 4 > $MEM_DUMP_PATH/register_config
    echo 0x171205a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171205a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171205c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171205c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171205d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171205d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171205e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171205e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120600 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120608 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120610 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120618 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120620 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120628 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120640 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120648 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120650 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120658 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120660 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120668 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120680 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120688 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120690 4 > $MEM_DUMP_PATH/register_config
    echo 0x17120698 4 > $MEM_DUMP_PATH/register_config
    echo 0x171206a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171206a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171206c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171206c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171206d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171206d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x171206e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171206e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x1712e000 4 > $MEM_DUMP_PATH/register_config
    echo 0x1712e800 4 > $MEM_DUMP_PATH/register_config
    echo 0x1712e808 4 > $MEM_DUMP_PATH/register_config
    echo 0x1712ffbc 4 > $MEM_DUMP_PATH/register_config
    echo 0x1712ffc8 4 > $MEM_DUMP_PATH/register_config
    echo 0x1712ffd0 68 > $MEM_DUMP_PATH/register_config
    echo 0x17130400 20 > $MEM_DUMP_PATH/register_config
    echo 0x17130600 20 > $MEM_DUMP_PATH/register_config
    echo 0x17130a00 20 > $MEM_DUMP_PATH/register_config
    echo 0x17130c00 4 > $MEM_DUMP_PATH/register_config
    echo 0x17130c20 4 > $MEM_DUMP_PATH/register_config
    echo 0x17130c40 4 > $MEM_DUMP_PATH/register_config
    echo 0x17130c60 4 > $MEM_DUMP_PATH/register_config
    echo 0x17130c80 4 > $MEM_DUMP_PATH/register_config
    echo 0x17130cc0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17130e00 8 > $MEM_DUMP_PATH/register_config
    echo 0x17130e50 4 > $MEM_DUMP_PATH/register_config
    echo 0x17130fb8 8 > $MEM_DUMP_PATH/register_config
    echo 0x17130fcc 52 > $MEM_DUMP_PATH/register_config
    echo 0x17140000 12 > $MEM_DUMP_PATH/register_config
    echo 0x17140010 12 > $MEM_DUMP_PATH/register_config
    echo 0x17140020 4 > $MEM_DUMP_PATH/register_config
    echo 0x17140028 4 > $MEM_DUMP_PATH/register_config
    echo 0x17140030 4 > $MEM_DUMP_PATH/register_config
    echo 0x17140080 4 > $MEM_DUMP_PATH/register_config
    echo 0x17140088 4 > $MEM_DUMP_PATH/register_config
    echo 0x17140090 4 > $MEM_DUMP_PATH/register_config
    echo 0x17140100 4 > $MEM_DUMP_PATH/register_config
    echo 0x17140108 4 > $MEM_DUMP_PATH/register_config
    echo 0x17140110 4 > $MEM_DUMP_PATH/register_config
    echo 0x1714c000 4 > $MEM_DUMP_PATH/register_config
    echo 0x1714c008 4 > $MEM_DUMP_PATH/register_config
    echo 0x1714c010 4 > $MEM_DUMP_PATH/register_config
    echo 0x1714f000 4 > $MEM_DUMP_PATH/register_config
    echo 0x1714ffd0 48 > $MEM_DUMP_PATH/register_config
    echo 0x17180000 12 > $MEM_DUMP_PATH/register_config
    echo 0x17180014 24 > $MEM_DUMP_PATH/register_config
    echo 0x17180070 4 > $MEM_DUMP_PATH/register_config
    echo 0x17180078 4 > $MEM_DUMP_PATH/register_config
    echo 0x171800c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x1718ffd0 48 > $MEM_DUMP_PATH/register_config
    echo 0x17190080 8 > $MEM_DUMP_PATH/register_config
    echo 0x17190100 8 > $MEM_DUMP_PATH/register_config
    echo 0x17190180 8 > $MEM_DUMP_PATH/register_config
    echo 0x17190200 8 > $MEM_DUMP_PATH/register_config
    echo 0x17190280 8 > $MEM_DUMP_PATH/register_config
    echo 0x17190300 8 > $MEM_DUMP_PATH/register_config
    echo 0x17190380 8 > $MEM_DUMP_PATH/register_config
    echo 0x17190400 48 > $MEM_DUMP_PATH/register_config
    echo 0x17190c00 12 > $MEM_DUMP_PATH/register_config
    echo 0x17190d00 8 > $MEM_DUMP_PATH/register_config
    echo 0x17190e00 4 > $MEM_DUMP_PATH/register_config
    echo 0x1719c000 4 > $MEM_DUMP_PATH/register_config
    echo 0x1719c008 4 > $MEM_DUMP_PATH/register_config
    echo 0x1719c010 4 > $MEM_DUMP_PATH/register_config
    echo 0x1719c018 4 > $MEM_DUMP_PATH/register_config
    echo 0x1719c100 8 > $MEM_DUMP_PATH/register_config
    echo 0x1719c180 8 > $MEM_DUMP_PATH/register_config
    echo 0x1719f000 8 > $MEM_DUMP_PATH/register_config
    echo 0x1719f010 4 > $MEM_DUMP_PATH/register_config
    echo 0x171a0070 4 > $MEM_DUMP_PATH/register_config
    echo 0x171a0078 8 > $MEM_DUMP_PATH/register_config
    echo 0x171a0120 4 > $MEM_DUMP_PATH/register_config
    echo 0x171ac000 4 > $MEM_DUMP_PATH/register_config
    echo 0x171ac100 4 > $MEM_DUMP_PATH/register_config
    echo 0x171ae100 4 > $MEM_DUMP_PATH/register_config
    echo 0x171c0000 12 > $MEM_DUMP_PATH/register_config
    echo 0x171c0014 24 > $MEM_DUMP_PATH/register_config
    echo 0x171c0070 4 > $MEM_DUMP_PATH/register_config
    echo 0x171c0078 4 > $MEM_DUMP_PATH/register_config
    echo 0x171c00c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x171cffd0 48 > $MEM_DUMP_PATH/register_config
    echo 0x171d0080 8 > $MEM_DUMP_PATH/register_config
    echo 0x171d0100 8 > $MEM_DUMP_PATH/register_config
    echo 0x171d0180 8 > $MEM_DUMP_PATH/register_config
    echo 0x171d0200 8 > $MEM_DUMP_PATH/register_config
    echo 0x171d0280 8 > $MEM_DUMP_PATH/register_config
    echo 0x171d0300 8 > $MEM_DUMP_PATH/register_config
    echo 0x171d0380 8 > $MEM_DUMP_PATH/register_config
    echo 0x171d0400 48 > $MEM_DUMP_PATH/register_config
    echo 0x171d0c00 12 > $MEM_DUMP_PATH/register_config
    echo 0x171d0d00 8 > $MEM_DUMP_PATH/register_config
    echo 0x171d0e00 4 > $MEM_DUMP_PATH/register_config
    echo 0x171dc000 4 > $MEM_DUMP_PATH/register_config
    echo 0x171dc008 4 > $MEM_DUMP_PATH/register_config
    echo 0x171dc010 4 > $MEM_DUMP_PATH/register_config
    echo 0x171dc018 4 > $MEM_DUMP_PATH/register_config
    echo 0x171dc100 8 > $MEM_DUMP_PATH/register_config
    echo 0x171dc180 8 > $MEM_DUMP_PATH/register_config
    echo 0x171df000 8 > $MEM_DUMP_PATH/register_config
    echo 0x171df010 4 > $MEM_DUMP_PATH/register_config
    echo 0x171e0070 4 > $MEM_DUMP_PATH/register_config
    echo 0x171e0078 8 > $MEM_DUMP_PATH/register_config
    echo 0x171e0120 4 > $MEM_DUMP_PATH/register_config
    echo 0x171ec000 4 > $MEM_DUMP_PATH/register_config
    echo 0x171ec100 4 > $MEM_DUMP_PATH/register_config
    echo 0x171ee100 4 > $MEM_DUMP_PATH/register_config
    echo 0x17200000 12 > $MEM_DUMP_PATH/register_config
    echo 0x17200014 24 > $MEM_DUMP_PATH/register_config
    echo 0x17200070 4 > $MEM_DUMP_PATH/register_config
    echo 0x17200078 4 > $MEM_DUMP_PATH/register_config
    echo 0x172000c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x1720ffd0 48 > $MEM_DUMP_PATH/register_config
    echo 0x17210080 8 > $MEM_DUMP_PATH/register_config
    echo 0x17210100 8 > $MEM_DUMP_PATH/register_config
    echo 0x17210180 8 > $MEM_DUMP_PATH/register_config
    echo 0x17210200 8 > $MEM_DUMP_PATH/register_config
    echo 0x17210280 8 > $MEM_DUMP_PATH/register_config
    echo 0x17210300 8 > $MEM_DUMP_PATH/register_config
    echo 0x17210380 8 > $MEM_DUMP_PATH/register_config
    echo 0x17210400 48 > $MEM_DUMP_PATH/register_config
    echo 0x17210c00 12 > $MEM_DUMP_PATH/register_config
    echo 0x17210d00 8 > $MEM_DUMP_PATH/register_config
    echo 0x17210e00 4 > $MEM_DUMP_PATH/register_config
    echo 0x1721c000 4 > $MEM_DUMP_PATH/register_config
    echo 0x1721c008 4 > $MEM_DUMP_PATH/register_config
    echo 0x1721c010 4 > $MEM_DUMP_PATH/register_config
    echo 0x1721c018 4 > $MEM_DUMP_PATH/register_config
    echo 0x1721c100 8 > $MEM_DUMP_PATH/register_config
    echo 0x1721c180 8 > $MEM_DUMP_PATH/register_config
    echo 0x1721f000 8 > $MEM_DUMP_PATH/register_config
    echo 0x1721f010 4 > $MEM_DUMP_PATH/register_config
    echo 0x17220070 4 > $MEM_DUMP_PATH/register_config
    echo 0x17220078 8 > $MEM_DUMP_PATH/register_config
    echo 0x17220120 4 > $MEM_DUMP_PATH/register_config
    echo 0x1722c000 4 > $MEM_DUMP_PATH/register_config
    echo 0x1722c100 4 > $MEM_DUMP_PATH/register_config
    echo 0x1722e100 4 > $MEM_DUMP_PATH/register_config
    echo 0x17240000 12 > $MEM_DUMP_PATH/register_config
    echo 0x17240014 24 > $MEM_DUMP_PATH/register_config
    echo 0x17240070 4 > $MEM_DUMP_PATH/register_config
    echo 0x17240078 4 > $MEM_DUMP_PATH/register_config
    echo 0x172400c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x1724ffd0 48 > $MEM_DUMP_PATH/register_config
    echo 0x17250080 8 > $MEM_DUMP_PATH/register_config
    echo 0x17250100 8 > $MEM_DUMP_PATH/register_config
    echo 0x17250180 8 > $MEM_DUMP_PATH/register_config
    echo 0x17250200 8 > $MEM_DUMP_PATH/register_config
    echo 0x17250280 8 > $MEM_DUMP_PATH/register_config
    echo 0x17250300 8 > $MEM_DUMP_PATH/register_config
    echo 0x17250380 8 > $MEM_DUMP_PATH/register_config
    echo 0x17250400 48 > $MEM_DUMP_PATH/register_config
    echo 0x17250c00 12 > $MEM_DUMP_PATH/register_config
    echo 0x17250d00 8 > $MEM_DUMP_PATH/register_config
    echo 0x17250e00 4 > $MEM_DUMP_PATH/register_config
    echo 0x1725c000 4 > $MEM_DUMP_PATH/register_config
    echo 0x1725c008 4 > $MEM_DUMP_PATH/register_config
    echo 0x1725c010 4 > $MEM_DUMP_PATH/register_config
    echo 0x1725c018 4 > $MEM_DUMP_PATH/register_config
    echo 0x1725c100 8 > $MEM_DUMP_PATH/register_config
    echo 0x1725c180 8 > $MEM_DUMP_PATH/register_config
    echo 0x1725f000 8 > $MEM_DUMP_PATH/register_config
    echo 0x1725f010 4 > $MEM_DUMP_PATH/register_config
    echo 0x17260070 4 > $MEM_DUMP_PATH/register_config
    echo 0x17260078 8 > $MEM_DUMP_PATH/register_config
    echo 0x17260120 4 > $MEM_DUMP_PATH/register_config
    echo 0x1726c000 4 > $MEM_DUMP_PATH/register_config
    echo 0x1726c100 4 > $MEM_DUMP_PATH/register_config
    echo 0x1726e100 4 > $MEM_DUMP_PATH/register_config
    echo 0x17280000 12 > $MEM_DUMP_PATH/register_config
    echo 0x17280014 24 > $MEM_DUMP_PATH/register_config
    echo 0x17280070 4 > $MEM_DUMP_PATH/register_config
    echo 0x17280078 4 > $MEM_DUMP_PATH/register_config
    echo 0x172800c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x1728ffd0 48 > $MEM_DUMP_PATH/register_config
    echo 0x17290080 8 > $MEM_DUMP_PATH/register_config
    echo 0x17290100 8 > $MEM_DUMP_PATH/register_config
    echo 0x17290180 8 > $MEM_DUMP_PATH/register_config
    echo 0x17290200 8 > $MEM_DUMP_PATH/register_config
    echo 0x17290280 8 > $MEM_DUMP_PATH/register_config
    echo 0x17290300 8 > $MEM_DUMP_PATH/register_config
    echo 0x17290380 8 > $MEM_DUMP_PATH/register_config
    echo 0x17290400 48 > $MEM_DUMP_PATH/register_config
    echo 0x17290c00 12 > $MEM_DUMP_PATH/register_config
    echo 0x17290d00 8 > $MEM_DUMP_PATH/register_config
    echo 0x17290e00 4 > $MEM_DUMP_PATH/register_config
    echo 0x1729c000 4 > $MEM_DUMP_PATH/register_config
    echo 0x1729c008 4 > $MEM_DUMP_PATH/register_config
    echo 0x1729c010 4 > $MEM_DUMP_PATH/register_config
    echo 0x1729c018 4 > $MEM_DUMP_PATH/register_config
    echo 0x1729c100 8 > $MEM_DUMP_PATH/register_config
    echo 0x1729c180 8 > $MEM_DUMP_PATH/register_config
    echo 0x1729f000 8 > $MEM_DUMP_PATH/register_config
    echo 0x1729f010 4 > $MEM_DUMP_PATH/register_config
    echo 0x172a0070 4 > $MEM_DUMP_PATH/register_config
    echo 0x172a0078 8 > $MEM_DUMP_PATH/register_config
    echo 0x172a0120 4 > $MEM_DUMP_PATH/register_config
    echo 0x172ac000 4 > $MEM_DUMP_PATH/register_config
    echo 0x172ac100 4 > $MEM_DUMP_PATH/register_config
    echo 0x172ae100 4 > $MEM_DUMP_PATH/register_config
    echo 0x172c0000 12 > $MEM_DUMP_PATH/register_config
    echo 0x172c0014 24 > $MEM_DUMP_PATH/register_config
    echo 0x172c0070 4 > $MEM_DUMP_PATH/register_config
    echo 0x172c0078 4 > $MEM_DUMP_PATH/register_config
    echo 0x172c00c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x172cffd0 48 > $MEM_DUMP_PATH/register_config
    echo 0x172d0080 8 > $MEM_DUMP_PATH/register_config
    echo 0x172d0100 8 > $MEM_DUMP_PATH/register_config
    echo 0x172d0180 8 > $MEM_DUMP_PATH/register_config
    echo 0x172d0200 8 > $MEM_DUMP_PATH/register_config
    echo 0x172d0280 8 > $MEM_DUMP_PATH/register_config
    echo 0x172d0300 8 > $MEM_DUMP_PATH/register_config
    echo 0x172d0380 8 > $MEM_DUMP_PATH/register_config
    echo 0x172d0400 48 > $MEM_DUMP_PATH/register_config
    echo 0x172d0c00 12 > $MEM_DUMP_PATH/register_config
    echo 0x172d0d00 8 > $MEM_DUMP_PATH/register_config
    echo 0x172d0e00 4 > $MEM_DUMP_PATH/register_config
    echo 0x172dc000 4 > $MEM_DUMP_PATH/register_config
    echo 0x172dc008 4 > $MEM_DUMP_PATH/register_config
    echo 0x172dc010 4 > $MEM_DUMP_PATH/register_config
    echo 0x172dc018 4 > $MEM_DUMP_PATH/register_config
    echo 0x172dc100 8 > $MEM_DUMP_PATH/register_config
    echo 0x172dc180 8 > $MEM_DUMP_PATH/register_config
    echo 0x172df000 8 > $MEM_DUMP_PATH/register_config
    echo 0x172df010 4 > $MEM_DUMP_PATH/register_config
    echo 0x172e0070 4 > $MEM_DUMP_PATH/register_config
    echo 0x172e0078 8 > $MEM_DUMP_PATH/register_config
    echo 0x172e0120 4 > $MEM_DUMP_PATH/register_config
    echo 0x172ec000 4 > $MEM_DUMP_PATH/register_config
    echo 0x172ec100 4 > $MEM_DUMP_PATH/register_config
    echo 0x172ee100 4 > $MEM_DUMP_PATH/register_config
    echo 0x17300000 12 > $MEM_DUMP_PATH/register_config
    echo 0x17300014 24 > $MEM_DUMP_PATH/register_config
    echo 0x17300070 4 > $MEM_DUMP_PATH/register_config
    echo 0x17300078 4 > $MEM_DUMP_PATH/register_config
    echo 0x173000c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x1730ffd0 48 > $MEM_DUMP_PATH/register_config
    echo 0x17310080 8 > $MEM_DUMP_PATH/register_config
    echo 0x17310100 8 > $MEM_DUMP_PATH/register_config
    echo 0x17310180 8 > $MEM_DUMP_PATH/register_config
    echo 0x17310200 8 > $MEM_DUMP_PATH/register_config
    echo 0x17310280 8 > $MEM_DUMP_PATH/register_config
    echo 0x17310300 8 > $MEM_DUMP_PATH/register_config
    echo 0x17310380 8 > $MEM_DUMP_PATH/register_config
    echo 0x17310400 48 > $MEM_DUMP_PATH/register_config
    echo 0x17310c00 12 > $MEM_DUMP_PATH/register_config
    echo 0x17310d00 8 > $MEM_DUMP_PATH/register_config
    echo 0x17310e00 4 > $MEM_DUMP_PATH/register_config
    echo 0x1731c000 4 > $MEM_DUMP_PATH/register_config
    echo 0x1731c008 4 > $MEM_DUMP_PATH/register_config
    echo 0x1731c010 4 > $MEM_DUMP_PATH/register_config
    echo 0x1731c018 4 > $MEM_DUMP_PATH/register_config
    echo 0x1731c100 8 > $MEM_DUMP_PATH/register_config
    echo 0x1731c180 8 > $MEM_DUMP_PATH/register_config
    echo 0x1731f000 8 > $MEM_DUMP_PATH/register_config
    echo 0x1731f010 4 > $MEM_DUMP_PATH/register_config
    echo 0x17320070 4 > $MEM_DUMP_PATH/register_config
    echo 0x17320078 8 > $MEM_DUMP_PATH/register_config
    echo 0x17320120 4 > $MEM_DUMP_PATH/register_config
    echo 0x1732c000 4 > $MEM_DUMP_PATH/register_config
    echo 0x1732c100 4 > $MEM_DUMP_PATH/register_config
    echo 0x1732e100 4 > $MEM_DUMP_PATH/register_config
    echo 0x17340000 12 > $MEM_DUMP_PATH/register_config
    echo 0x17340014 24 > $MEM_DUMP_PATH/register_config
    echo 0x17340070 4 > $MEM_DUMP_PATH/register_config
    echo 0x17340078 4 > $MEM_DUMP_PATH/register_config
    echo 0x173400c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x1734ffd0 48 > $MEM_DUMP_PATH/register_config
    echo 0x17350080 8 > $MEM_DUMP_PATH/register_config
    echo 0x17350100 8 > $MEM_DUMP_PATH/register_config
    echo 0x17350180 8 > $MEM_DUMP_PATH/register_config
    echo 0x17350200 8 > $MEM_DUMP_PATH/register_config
    echo 0x17350280 8 > $MEM_DUMP_PATH/register_config
    echo 0x17350300 8 > $MEM_DUMP_PATH/register_config
    echo 0x17350380 8 > $MEM_DUMP_PATH/register_config
    echo 0x17350400 48 > $MEM_DUMP_PATH/register_config
    echo 0x17350c00 12 > $MEM_DUMP_PATH/register_config
    echo 0x17350d00 8 > $MEM_DUMP_PATH/register_config
    echo 0x17350e00 4 > $MEM_DUMP_PATH/register_config
    echo 0x1735c000 4 > $MEM_DUMP_PATH/register_config
    echo 0x1735c008 4 > $MEM_DUMP_PATH/register_config
    echo 0x1735c010 4 > $MEM_DUMP_PATH/register_config
    echo 0x1735c018 4 > $MEM_DUMP_PATH/register_config
    echo 0x1735c100 8 > $MEM_DUMP_PATH/register_config
    echo 0x1735c180 8 > $MEM_DUMP_PATH/register_config
    echo 0x1735f000 8 > $MEM_DUMP_PATH/register_config
    echo 0x1735f010 4 > $MEM_DUMP_PATH/register_config
    echo 0x17360070 4 > $MEM_DUMP_PATH/register_config
    echo 0x17360078 8 > $MEM_DUMP_PATH/register_config
    echo 0x17360120 4 > $MEM_DUMP_PATH/register_config
    echo 0x1736c000 4 > $MEM_DUMP_PATH/register_config
    echo 0x1736c100 4 > $MEM_DUMP_PATH/register_config
    echo 0x1736e100 4 > $MEM_DUMP_PATH/register_config
    echo 0x17380000 16 > $MEM_DUMP_PATH/register_config
    echo 0x17380020 8 > $MEM_DUMP_PATH/register_config
    echo 0x17380030 4 > $MEM_DUMP_PATH/register_config
    echo 0x17380084 116 > $MEM_DUMP_PATH/register_config
    echo 0x17380104 116 > $MEM_DUMP_PATH/register_config
    echo 0x17380184 116 > $MEM_DUMP_PATH/register_config
    echo 0x17380204 116 > $MEM_DUMP_PATH/register_config
    echo 0x17380284 116 > $MEM_DUMP_PATH/register_config
    echo 0x17380304 116 > $MEM_DUMP_PATH/register_config
    echo 0x17380384 116 > $MEM_DUMP_PATH/register_config
    echo 0x17380420 928 > $MEM_DUMP_PATH/register_config
    echo 0x17380c08 232 > $MEM_DUMP_PATH/register_config
    echo 0x17380d04 116 > $MEM_DUMP_PATH/register_config
    echo 0x17380e08 232 > $MEM_DUMP_PATH/register_config
    echo 0x17386100 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386108 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386110 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386118 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386120 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386128 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386130 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386138 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386140 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386148 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386150 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386158 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386160 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386168 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386170 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386178 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386180 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386188 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386190 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386198 4 > $MEM_DUMP_PATH/register_config
    echo 0x173861a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173861a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173861b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173861b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173861c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173861c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173861d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173861d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173861e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173861e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173861f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173861f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386200 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386208 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386210 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386218 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386220 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386228 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386230 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386238 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386240 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386248 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386250 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386258 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386260 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386268 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386270 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386278 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386280 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386288 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386290 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386298 4 > $MEM_DUMP_PATH/register_config
    echo 0x173862a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173862a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173862b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173862b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173862c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173862c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173862d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173862d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173862e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173862e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173862f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173862f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386300 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386308 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386310 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386318 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386320 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386328 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386330 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386338 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386340 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386348 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386350 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386358 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386360 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386368 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386370 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386378 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386380 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386388 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386390 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386398 4 > $MEM_DUMP_PATH/register_config
    echo 0x173863a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173863a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173863b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173863b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173863c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173863c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173863d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173863d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173863e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173863e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173863f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173863f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386400 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386408 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386410 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386418 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386420 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386428 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386430 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386438 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386440 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386448 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386450 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386458 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386460 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386468 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386470 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386478 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386480 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386488 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386490 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386498 4 > $MEM_DUMP_PATH/register_config
    echo 0x173864a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173864a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173864b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173864b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173864c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173864c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173864d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173864d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173864e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173864e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173864f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173864f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386500 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386508 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386510 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386518 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386520 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386528 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386530 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386538 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386540 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386548 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386550 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386558 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386560 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386568 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386570 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386578 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386580 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386588 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386590 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386598 4 > $MEM_DUMP_PATH/register_config
    echo 0x173865a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173865a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173865b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173865b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173865c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173865c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173865d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173865d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173865e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173865e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173865f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173865f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386600 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386608 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386610 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386618 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386620 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386628 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386630 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386638 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386640 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386648 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386650 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386658 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386660 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386668 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386670 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386678 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386680 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386688 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386690 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386698 4 > $MEM_DUMP_PATH/register_config
    echo 0x173866a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173866a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173866b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173866b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173866c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173866c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173866d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173866d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173866e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173866e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173866f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173866f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386700 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386708 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386710 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386718 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386720 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386728 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386730 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386738 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386740 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386748 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386750 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386758 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386760 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386768 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386770 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386778 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386780 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386788 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386790 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386798 4 > $MEM_DUMP_PATH/register_config
    echo 0x173867a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173867a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173867b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173867b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173867c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173867c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173867d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173867d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173867e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173867e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173867f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173867f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386800 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386808 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386810 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386818 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386820 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386828 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386830 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386838 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386840 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386848 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386850 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386858 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386860 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386868 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386870 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386878 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386880 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386888 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386890 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386898 4 > $MEM_DUMP_PATH/register_config
    echo 0x173868a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173868a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173868b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173868b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173868c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173868c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173868d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173868d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173868e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173868e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173868f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173868f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386900 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386908 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386910 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386918 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386920 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386928 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386930 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386938 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386940 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386948 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386950 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386958 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386960 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386968 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386970 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386978 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386980 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386988 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386990 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386998 4 > $MEM_DUMP_PATH/register_config
    echo 0x173869a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173869a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173869b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173869b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173869c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173869c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173869d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173869d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173869e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173869e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173869f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173869f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386a00 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386a08 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386a10 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386a18 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386a20 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386a28 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386a30 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386a38 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386a40 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386a48 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386a50 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386a58 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386a60 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386a68 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386a70 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386a78 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386a80 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386a88 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386a90 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386a98 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386aa0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386aa8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ab0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ab8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ac0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ac8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ad0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ad8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ae0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ae8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386af0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386af8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386b00 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386b08 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386b10 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386b18 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386b20 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386b28 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386b30 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386b38 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386b40 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386b48 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386b50 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386b58 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386b60 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386b68 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386b70 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386b78 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386b80 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386b88 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386b90 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386b98 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ba0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ba8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386bb0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386bb8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386bc0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386bc8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386bd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386bd8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386be0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386be8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386bf0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386bf8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386c00 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386c08 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386c10 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386c18 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386c20 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386c28 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386c30 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386c38 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386c40 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386c48 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386c50 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386c58 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386c60 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386c68 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386c70 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386c78 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386c80 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386c88 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386c90 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386c98 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ca0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ca8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386cb0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386cb8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386cc0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386cc8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386cd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386cd8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ce0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ce8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386cf0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386cf8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386d00 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386d08 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386d10 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386d18 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386d20 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386d28 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386d30 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386d38 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386d40 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386d48 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386d50 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386d58 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386d60 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386d68 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386d70 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386d78 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386d80 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386d88 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386d90 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386d98 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386da0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386da8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386db0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386db8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386dc0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386dc8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386dd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386dd8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386de0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386de8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386df0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386df8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386e00 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386e08 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386e10 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386e18 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386e20 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386e28 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386e30 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386e38 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386e40 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386e48 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386e50 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386e58 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386e60 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386e68 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386e70 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386e78 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386e80 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386e88 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386e90 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386e98 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ea0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ea8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386eb0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386eb8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ec0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ec8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ed0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ed8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ee0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ee8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ef0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ef8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386f00 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386f08 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386f10 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386f18 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386f20 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386f28 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386f30 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386f38 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386f40 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386f48 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386f50 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386f58 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386f60 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386f68 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386f70 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386f78 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386f80 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386f88 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386f90 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386f98 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386fa0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386fa8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386fb0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386fb8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386fc0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386fc8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386fd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386fd8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386fe0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386fe8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ff0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17386ff8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387008 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387010 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387018 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387020 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387028 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387030 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387038 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387040 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387048 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387050 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387058 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387060 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387068 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387070 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387078 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387080 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387088 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387090 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387098 4 > $MEM_DUMP_PATH/register_config
    echo 0x173870a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173870a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173870b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173870b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173870c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173870c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173870d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173870d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173870e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173870e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173870f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173870f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387100 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387108 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387110 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387118 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387120 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387128 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387130 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387138 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387140 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387148 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387150 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387158 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387160 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387168 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387170 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387178 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387180 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387188 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387190 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387198 4 > $MEM_DUMP_PATH/register_config
    echo 0x173871a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173871a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173871b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173871b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173871c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173871c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173871d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173871d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173871e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173871e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173871f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173871f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387200 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387208 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387210 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387218 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387220 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387228 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387230 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387238 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387240 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387248 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387250 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387258 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387260 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387268 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387270 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387278 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387280 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387288 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387290 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387298 4 > $MEM_DUMP_PATH/register_config
    echo 0x173872a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173872a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173872b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173872b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173872c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173872c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173872d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173872d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173872e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173872e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173872f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173872f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387300 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387308 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387310 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387318 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387320 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387328 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387330 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387338 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387340 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387348 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387350 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387358 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387360 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387368 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387370 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387378 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387380 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387388 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387390 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387398 4 > $MEM_DUMP_PATH/register_config
    echo 0x173873a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173873a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173873b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173873b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173873c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173873c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173873d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173873d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173873e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173873e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173873f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173873f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387400 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387408 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387410 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387418 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387420 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387428 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387430 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387438 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387440 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387448 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387450 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387458 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387460 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387468 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387470 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387478 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387480 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387488 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387490 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387498 4 > $MEM_DUMP_PATH/register_config
    echo 0x173874a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173874a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173874b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173874b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173874c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173874c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173874d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173874d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173874e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173874e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173874f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173874f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387500 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387508 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387510 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387518 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387520 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387528 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387530 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387538 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387540 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387548 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387550 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387558 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387560 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387568 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387570 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387578 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387580 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387588 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387590 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387598 4 > $MEM_DUMP_PATH/register_config
    echo 0x173875a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173875a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173875b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173875b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173875c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173875c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173875d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173875d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173875e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173875e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173875f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173875f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387600 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387608 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387610 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387618 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387620 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387628 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387630 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387638 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387640 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387648 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387650 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387658 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387660 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387668 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387670 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387678 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387680 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387688 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387690 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387698 4 > $MEM_DUMP_PATH/register_config
    echo 0x173876a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173876a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173876b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173876b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173876c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173876c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173876d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173876d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173876e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173876e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173876f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173876f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387700 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387708 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387710 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387718 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387720 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387728 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387730 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387738 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387740 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387748 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387750 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387758 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387760 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387768 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387770 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387778 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387780 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387788 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387790 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387798 4 > $MEM_DUMP_PATH/register_config
    echo 0x173877a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173877a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173877b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173877b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173877c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173877c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173877d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173877d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173877e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173877e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173877f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173877f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387800 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387808 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387810 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387818 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387820 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387828 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387830 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387838 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387840 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387848 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387850 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387858 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387860 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387868 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387870 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387878 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387880 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387888 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387890 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387898 4 > $MEM_DUMP_PATH/register_config
    echo 0x173878a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173878a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173878b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173878b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173878c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173878c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173878d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173878d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173878e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173878e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173878f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173878f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387900 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387908 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387910 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387918 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387920 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387928 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387930 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387938 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387940 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387948 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387950 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387958 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387960 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387968 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387970 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387978 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387980 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387988 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387990 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387998 4 > $MEM_DUMP_PATH/register_config
    echo 0x173879a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173879a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173879b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173879b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173879c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173879c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173879d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173879d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173879e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173879e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x173879f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x173879f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387a00 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387a08 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387a10 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387a18 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387a20 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387a28 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387a30 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387a38 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387a40 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387a48 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387a50 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387a58 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387a60 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387a68 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387a70 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387a78 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387a80 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387a88 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387a90 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387a98 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387aa0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387aa8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387ab0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387ab8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387ac0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387ac8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387ad0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387ad8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387ae0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387ae8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387af0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387af8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387b00 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387b08 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387b10 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387b18 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387b20 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387b28 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387b30 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387b38 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387b40 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387b48 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387b50 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387b58 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387b60 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387b68 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387b70 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387b78 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387b80 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387b88 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387b90 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387b98 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387ba0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387ba8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387bb0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387bb8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387bc0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387bc8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387bd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387bd8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387be0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387be8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387bf0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387bf8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387c00 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387c08 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387c10 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387c18 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387c20 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387c28 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387c30 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387c38 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387c40 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387c48 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387c50 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387c58 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387c60 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387c68 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387c70 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387c78 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387c80 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387c88 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387c90 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387c98 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387ca0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387ca8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387cb0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387cb8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387cc0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387cc8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387cd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387cd8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387ce0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387ce8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387cf0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387cf8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387d00 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387d08 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387d10 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387d18 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387d20 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387d28 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387d30 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387d38 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387d40 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387d48 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387d50 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387d58 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387d60 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387d68 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387d70 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387d78 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387d80 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387d88 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387d90 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387d98 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387da0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387da8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387db0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387db8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387dc0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387dc8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387dd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387dd8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387de0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387de8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387df0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17387df8 4 > $MEM_DUMP_PATH/register_config
    echo 0x1738e008 232 > $MEM_DUMP_PATH/register_config
    echo 0x1738e104 116 > $MEM_DUMP_PATH/register_config
    echo 0x1738e184 116 > $MEM_DUMP_PATH/register_config
    echo 0x1738e204 116 > $MEM_DUMP_PATH/register_config
    echo 0x1738ea00 4 > $MEM_DUMP_PATH/register_config
    echo 0x1738ea08 4 > $MEM_DUMP_PATH/register_config
    echo 0x1738ea10 4 > $MEM_DUMP_PATH/register_config
    echo 0x1738ea18 4 > $MEM_DUMP_PATH/register_config
    echo 0x1738ea20 4 > $MEM_DUMP_PATH/register_config
    echo 0x1738ea28 4 > $MEM_DUMP_PATH/register_config
    echo 0x1738ea30 4 > $MEM_DUMP_PATH/register_config
    echo 0x1738ea38 4 > $MEM_DUMP_PATH/register_config
    echo 0x1738ea40 4 > $MEM_DUMP_PATH/register_config
    echo 0x1738ea48 4 > $MEM_DUMP_PATH/register_config
    echo 0x1738ea50 4 > $MEM_DUMP_PATH/register_config
    echo 0x1738ea58 4 > $MEM_DUMP_PATH/register_config
    echo 0x1738ea60 4 > $MEM_DUMP_PATH/register_config
    echo 0x1738ea68 4 > $MEM_DUMP_PATH/register_config
    echo 0x1738ea70 4 > $MEM_DUMP_PATH/register_config
    echo 0x1738f000 4 > $MEM_DUMP_PATH/register_config
    echo 0x1738ffd0 48 > $MEM_DUMP_PATH/register_config
    echo 0x17400004 4 > $MEM_DUMP_PATH/register_config
    echo 0x17400038 8 > $MEM_DUMP_PATH/register_config
    echo 0x17400044 8 > $MEM_DUMP_PATH/register_config
    echo 0x174000f0 132 > $MEM_DUMP_PATH/register_config
    echo 0x17400200 132 > $MEM_DUMP_PATH/register_config
    echo 0x17400438 4 > $MEM_DUMP_PATH/register_config
    echo 0x17400444 4 > $MEM_DUMP_PATH/register_config
    echo 0x17410000 4 > $MEM_DUMP_PATH/register_config
    echo 0x1741000c 16 > $MEM_DUMP_PATH/register_config
    echo 0x17410020 4 > $MEM_DUMP_PATH/register_config
    echo 0x17411000 4 > $MEM_DUMP_PATH/register_config
    echo 0x1741100c 16 > $MEM_DUMP_PATH/register_config
    echo 0x17411020 4 > $MEM_DUMP_PATH/register_config
    echo 0x17420000 12 > $MEM_DUMP_PATH/register_config
    echo 0x17420040 28 > $MEM_DUMP_PATH/register_config
    echo 0x17420080 56 > $MEM_DUMP_PATH/register_config
    echo 0x17420fc0 80 > $MEM_DUMP_PATH/register_config
    echo 0x17421fd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17422000 20 > $MEM_DUMP_PATH/register_config
    echo 0x17422020 32 > $MEM_DUMP_PATH/register_config
    echo 0x17422fd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17423000 64 > $MEM_DUMP_PATH/register_config
    echo 0x17423fd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17425000 64 > $MEM_DUMP_PATH/register_config
    echo 0x17425fd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17426000 20 > $MEM_DUMP_PATH/register_config
    echo 0x17426020 32 > $MEM_DUMP_PATH/register_config
    echo 0x17426fd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17427000 64 > $MEM_DUMP_PATH/register_config
    echo 0x17427fd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17429000 64 > $MEM_DUMP_PATH/register_config
    echo 0x17429fd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x1742b000 64 > $MEM_DUMP_PATH/register_config
    echo 0x1742bfd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x1742d000 64 > $MEM_DUMP_PATH/register_config
    echo 0x1742dfd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17600004 4 > $MEM_DUMP_PATH/register_config
    echo 0x17600010 12 > $MEM_DUMP_PATH/register_config
    echo 0x17600024 12 > $MEM_DUMP_PATH/register_config
    echo 0x17600034 4 > $MEM_DUMP_PATH/register_config
    echo 0x17600040 8 > $MEM_DUMP_PATH/register_config
    echo 0x17600050 28 > $MEM_DUMP_PATH/register_config
    echo 0x17600070 28 > $MEM_DUMP_PATH/register_config
    echo 0x17600094 12 > $MEM_DUMP_PATH/register_config
    echo 0x176000a8 44 > $MEM_DUMP_PATH/register_config
    echo 0x176000d8 56 > $MEM_DUMP_PATH/register_config
    echo 0x17600118 20 > $MEM_DUMP_PATH/register_config
    echo 0x17600134 12 > $MEM_DUMP_PATH/register_config
    echo 0x17600148 20 > $MEM_DUMP_PATH/register_config
    echo 0x17600160 12 > $MEM_DUMP_PATH/register_config
    echo 0x17600170 12 > $MEM_DUMP_PATH/register_config
    echo 0x17600180 16 > $MEM_DUMP_PATH/register_config
    echo 0x17600210 8 > $MEM_DUMP_PATH/register_config
    echo 0x17600234 8 > $MEM_DUMP_PATH/register_config
    echo 0x17600240 44 > $MEM_DUMP_PATH/register_config
    echo 0x176002b4 8 > $MEM_DUMP_PATH/register_config
    echo 0x17600404 12 > $MEM_DUMP_PATH/register_config
    echo 0x1760041c 12 > $MEM_DUMP_PATH/register_config
    echo 0x17600434 4 > $MEM_DUMP_PATH/register_config
    echo 0x1760043c 8 > $MEM_DUMP_PATH/register_config
    echo 0x17600460 8 > $MEM_DUMP_PATH/register_config
    echo 0x17600470 8 > $MEM_DUMP_PATH/register_config
    echo 0x17600480 8 > $MEM_DUMP_PATH/register_config
    echo 0x17600490 8 > $MEM_DUMP_PATH/register_config
    echo 0x176004a0 8 > $MEM_DUMP_PATH/register_config
    echo 0x176004b0 8 > $MEM_DUMP_PATH/register_config
    echo 0x176004c0 8 > $MEM_DUMP_PATH/register_config
    echo 0x176004d0 8 > $MEM_DUMP_PATH/register_config
    echo 0x176004e0 8 > $MEM_DUMP_PATH/register_config
    echo 0x176004f0 28 > $MEM_DUMP_PATH/register_config
    echo 0x176009fc 4 > $MEM_DUMP_PATH/register_config
    echo 0x17601000 48 > $MEM_DUMP_PATH/register_config
    echo 0x17602000 260 > $MEM_DUMP_PATH/register_config
    echo 0x17603000 48 > $MEM_DUMP_PATH/register_config
    echo 0x17604000 260 > $MEM_DUMP_PATH/register_config
    echo 0x17605000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17606000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17607000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17608004 12 > $MEM_DUMP_PATH/register_config
    echo 0x17608020 8 > $MEM_DUMP_PATH/register_config
    echo 0x1760f000 24 > $MEM_DUMP_PATH/register_config
    echo 0x17610000 12 > $MEM_DUMP_PATH/register_config
    echo 0x17610010 36 > $MEM_DUMP_PATH/register_config
    echo 0x17611000 12 > $MEM_DUMP_PATH/register_config
    echo 0x17611010 12 > $MEM_DUMP_PATH/register_config
    echo 0x17612000 16 > $MEM_DUMP_PATH/register_config
    echo 0x17612100 8 > $MEM_DUMP_PATH/register_config
    echo 0x17612208 8 > $MEM_DUMP_PATH/register_config
    echo 0x17612304 4 > $MEM_DUMP_PATH/register_config
    echo 0x17612500 24 > $MEM_DUMP_PATH/register_config
    echo 0x17613000 8 > $MEM_DUMP_PATH/register_config
    echo 0x1761300c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613014 12 > $MEM_DUMP_PATH/register_config
    echo 0x17613030 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761304c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613054 12 > $MEM_DUMP_PATH/register_config
    echo 0x17613070 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761308c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613094 12 > $MEM_DUMP_PATH/register_config
    echo 0x176130b0 12 > $MEM_DUMP_PATH/register_config
    echo 0x176130cc 4 > $MEM_DUMP_PATH/register_config
    echo 0x176130d4 12 > $MEM_DUMP_PATH/register_config
    echo 0x176130f0 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761310c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613114 12 > $MEM_DUMP_PATH/register_config
    echo 0x17613130 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761314c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613154 12 > $MEM_DUMP_PATH/register_config
    echo 0x17613170 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761318c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613194 12 > $MEM_DUMP_PATH/register_config
    echo 0x176131b0 12 > $MEM_DUMP_PATH/register_config
    echo 0x176131cc 4 > $MEM_DUMP_PATH/register_config
    echo 0x176131d4 12 > $MEM_DUMP_PATH/register_config
    echo 0x176131f0 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761320c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613214 12 > $MEM_DUMP_PATH/register_config
    echo 0x17613230 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761324c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613254 12 > $MEM_DUMP_PATH/register_config
    echo 0x17613270 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761328c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613294 12 > $MEM_DUMP_PATH/register_config
    echo 0x176132b0 12 > $MEM_DUMP_PATH/register_config
    echo 0x176132cc 4 > $MEM_DUMP_PATH/register_config
    echo 0x176132d4 12 > $MEM_DUMP_PATH/register_config
    echo 0x176132f0 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761330c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613314 12 > $MEM_DUMP_PATH/register_config
    echo 0x17613330 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761334c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613354 12 > $MEM_DUMP_PATH/register_config
    echo 0x17613370 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761338c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613394 12 > $MEM_DUMP_PATH/register_config
    echo 0x176133b0 12 > $MEM_DUMP_PATH/register_config
    echo 0x176133cc 4 > $MEM_DUMP_PATH/register_config
    echo 0x176133d4 12 > $MEM_DUMP_PATH/register_config
    echo 0x176133f0 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761340c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613414 12 > $MEM_DUMP_PATH/register_config
    echo 0x17613430 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761344c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613454 12 > $MEM_DUMP_PATH/register_config
    echo 0x17613470 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761348c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613494 12 > $MEM_DUMP_PATH/register_config
    echo 0x176134b0 12 > $MEM_DUMP_PATH/register_config
    echo 0x176134cc 4 > $MEM_DUMP_PATH/register_config
    echo 0x176134d4 12 > $MEM_DUMP_PATH/register_config
    echo 0x176134f0 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761350c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613514 12 > $MEM_DUMP_PATH/register_config
    echo 0x17613530 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761354c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613554 12 > $MEM_DUMP_PATH/register_config
    echo 0x17613570 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761358c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613594 12 > $MEM_DUMP_PATH/register_config
    echo 0x176135b0 12 > $MEM_DUMP_PATH/register_config
    echo 0x176135cc 4 > $MEM_DUMP_PATH/register_config
    echo 0x176135d4 12 > $MEM_DUMP_PATH/register_config
    echo 0x176135f0 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761360c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613614 12 > $MEM_DUMP_PATH/register_config
    echo 0x17613630 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761364c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613654 12 > $MEM_DUMP_PATH/register_config
    echo 0x17613670 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761368c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613694 12 > $MEM_DUMP_PATH/register_config
    echo 0x176136b0 12 > $MEM_DUMP_PATH/register_config
    echo 0x176136cc 4 > $MEM_DUMP_PATH/register_config
    echo 0x176136d4 12 > $MEM_DUMP_PATH/register_config
    echo 0x176136f0 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761370c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613714 12 > $MEM_DUMP_PATH/register_config
    echo 0x17613730 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761374c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613754 12 > $MEM_DUMP_PATH/register_config
    echo 0x17613770 12 > $MEM_DUMP_PATH/register_config
    echo 0x1761378c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17613794 12 > $MEM_DUMP_PATH/register_config
    echo 0x176137b0 12 > $MEM_DUMP_PATH/register_config
    echo 0x176137cc 4 > $MEM_DUMP_PATH/register_config
    echo 0x176137d4 12 > $MEM_DUMP_PATH/register_config
    echo 0x176137f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17800000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17800008 72 > $MEM_DUMP_PATH/register_config
    echo 0x17800054 32 > $MEM_DUMP_PATH/register_config
    echo 0x178000f0 12 > $MEM_DUMP_PATH/register_config
    echo 0x17800100 8 > $MEM_DUMP_PATH/register_config
    echo 0x17810000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17810008 72 > $MEM_DUMP_PATH/register_config
    echo 0x17810054 32 > $MEM_DUMP_PATH/register_config
    echo 0x178100f0 12 > $MEM_DUMP_PATH/register_config
    echo 0x17810100 8 > $MEM_DUMP_PATH/register_config
    echo 0x17820000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17820008 72 > $MEM_DUMP_PATH/register_config
    echo 0x17820054 32 > $MEM_DUMP_PATH/register_config
    echo 0x178200f0 12 > $MEM_DUMP_PATH/register_config
    echo 0x17820100 8 > $MEM_DUMP_PATH/register_config
    echo 0x17830000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17830008 72 > $MEM_DUMP_PATH/register_config
    echo 0x17830054 32 > $MEM_DUMP_PATH/register_config
    echo 0x178300f0 12 > $MEM_DUMP_PATH/register_config
    echo 0x17830100 8 > $MEM_DUMP_PATH/register_config
    echo 0x17840000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17840008 72 > $MEM_DUMP_PATH/register_config
    echo 0x17840054 32 > $MEM_DUMP_PATH/register_config
    echo 0x178400f0 12 > $MEM_DUMP_PATH/register_config
    echo 0x17840100 8 > $MEM_DUMP_PATH/register_config
    echo 0x17848000 20 > $MEM_DUMP_PATH/register_config
    echo 0x17850000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17850008 72 > $MEM_DUMP_PATH/register_config
    echo 0x17850054 32 > $MEM_DUMP_PATH/register_config
    echo 0x178500f0 12 > $MEM_DUMP_PATH/register_config
    echo 0x17850100 8 > $MEM_DUMP_PATH/register_config
    echo 0x17858000 20 > $MEM_DUMP_PATH/register_config
    echo 0x17860000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17860008 72 > $MEM_DUMP_PATH/register_config
    echo 0x17860054 32 > $MEM_DUMP_PATH/register_config
    echo 0x178600f0 12 > $MEM_DUMP_PATH/register_config
    echo 0x17860100 8 > $MEM_DUMP_PATH/register_config
    echo 0x17868000 20 > $MEM_DUMP_PATH/register_config
    echo 0x17870000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17870008 72 > $MEM_DUMP_PATH/register_config
    echo 0x17870054 32 > $MEM_DUMP_PATH/register_config
    echo 0x178700f0 12 > $MEM_DUMP_PATH/register_config
    echo 0x17870100 8 > $MEM_DUMP_PATH/register_config
    echo 0x17878000 20 > $MEM_DUMP_PATH/register_config
    echo 0x17880000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17880008 72 > $MEM_DUMP_PATH/register_config
    echo 0x17880068 8 > $MEM_DUMP_PATH/register_config
    echo 0x178800f0 24 > $MEM_DUMP_PATH/register_config
    echo 0x17888000 24 > $MEM_DUMP_PATH/register_config
    echo 0x17890000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17890008 72 > $MEM_DUMP_PATH/register_config
    echo 0x17890068 8 > $MEM_DUMP_PATH/register_config
    echo 0x178900f0 24 > $MEM_DUMP_PATH/register_config
    echo 0x17898000 24 > $MEM_DUMP_PATH/register_config
    echo 0x178a0000 4 > $MEM_DUMP_PATH/register_config
    echo 0x178a0008 72 > $MEM_DUMP_PATH/register_config
    echo 0x178a0054 52 > $MEM_DUMP_PATH/register_config
    echo 0x178a0090 464 > $MEM_DUMP_PATH/register_config
    echo 0x178c0000 584 > $MEM_DUMP_PATH/register_config
    echo 0x178c8000 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8008 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8010 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8018 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8020 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8028 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8030 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8038 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8040 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8048 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8050 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8058 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8060 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8068 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8070 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8078 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8080 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8088 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8090 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8098 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c80a0 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c80a8 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c80b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c80b8 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c80c0 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c80c8 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c80d0 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c80d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c80e0 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c80e8 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c80f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c80f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8100 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8108 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8110 4 > $MEM_DUMP_PATH/register_config
    echo 0x178c8118 4 > $MEM_DUMP_PATH/register_config
    echo 0x178cc000 36 > $MEM_DUMP_PATH/register_config
    echo 0x178cc030 76 > $MEM_DUMP_PATH/register_config
    echo 0x178cc090 136 > $MEM_DUMP_PATH/register_config
    echo 0x17900000 4 > $MEM_DUMP_PATH/register_config
    echo 0x1790000c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17900040 24 > $MEM_DUMP_PATH/register_config
    echo 0x17900900 20 > $MEM_DUMP_PATH/register_config
    echo 0x17900c00 8 > $MEM_DUMP_PATH/register_config
    echo 0x17900c0c 24 > $MEM_DUMP_PATH/register_config
    echo 0x17900c40 8 > $MEM_DUMP_PATH/register_config
    echo 0x17900fd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17901000 4 > $MEM_DUMP_PATH/register_config
    echo 0x1790100c 4 > $MEM_DUMP_PATH/register_config
    echo 0x17901040 24 > $MEM_DUMP_PATH/register_config
    echo 0x17901900 20 > $MEM_DUMP_PATH/register_config
    echo 0x17901c00 8 > $MEM_DUMP_PATH/register_config
    echo 0x17901c0c 24 > $MEM_DUMP_PATH/register_config
    echo 0x17901c40 8 > $MEM_DUMP_PATH/register_config
    echo 0x17901fd0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17a00000 212 > $MEM_DUMP_PATH/register_config
    echo 0x17a000d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17a00100 12 > $MEM_DUMP_PATH/register_config
    echo 0x17a00200 20 > $MEM_DUMP_PATH/register_config
    echo 0x17a00224 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a00244 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a00264 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a00284 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a002a4 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a002c4 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a002e4 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a00400 12 > $MEM_DUMP_PATH/register_config
    echo 0x17a00450 24 > $MEM_DUMP_PATH/register_config
    echo 0x17a00490 44 > $MEM_DUMP_PATH/register_config
    echo 0x17a00500 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a00600 512 > $MEM_DUMP_PATH/register_config
    echo 0x17a00d00 8 > $MEM_DUMP_PATH/register_config
    echo 0x17a00d10 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a00d30 320 > $MEM_DUMP_PATH/register_config
    echo 0x17a00fb0 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a00fd0 320 > $MEM_DUMP_PATH/register_config
    echo 0x17a01250 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a01270 320 > $MEM_DUMP_PATH/register_config
    echo 0x17a014f0 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a01510 320 > $MEM_DUMP_PATH/register_config
    echo 0x17a03d44 4 > $MEM_DUMP_PATH/register_config
    echo 0x17a03d4c 8 > $MEM_DUMP_PATH/register_config
    echo 0x17a10000 76 > $MEM_DUMP_PATH/register_config
    echo 0x17a10050 132 > $MEM_DUMP_PATH/register_config
    echo 0x17a100d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17a10100 4 > $MEM_DUMP_PATH/register_config
    echo 0x17a10108 4 > $MEM_DUMP_PATH/register_config
    echo 0x17a10204 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a10224 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a10244 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a10264 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a10284 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a102a4 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a102c4 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a102e4 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a10400 12 > $MEM_DUMP_PATH/register_config
    echo 0x17a10450 24 > $MEM_DUMP_PATH/register_config
    echo 0x17a104a0 28 > $MEM_DUMP_PATH/register_config
    echo 0x17a10500 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a10600 512 > $MEM_DUMP_PATH/register_config
    echo 0x17a10d00 8 > $MEM_DUMP_PATH/register_config
    echo 0x17a10d10 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a10d30 320 > $MEM_DUMP_PATH/register_config
    echo 0x17a10fb0 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a10fd0 320 > $MEM_DUMP_PATH/register_config
    echo 0x17a11250 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a11270 320 > $MEM_DUMP_PATH/register_config
    echo 0x17a114f0 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a11510 320 > $MEM_DUMP_PATH/register_config
    echo 0x17a13d44 4 > $MEM_DUMP_PATH/register_config
    echo 0x17a13d4c 8 > $MEM_DUMP_PATH/register_config
    echo 0x17a13e00 12 > $MEM_DUMP_PATH/register_config
    echo 0x17a20000 76 > $MEM_DUMP_PATH/register_config
    echo 0x17a20050 132 > $MEM_DUMP_PATH/register_config
    echo 0x17a200d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17a20100 4 > $MEM_DUMP_PATH/register_config
    echo 0x17a20108 4 > $MEM_DUMP_PATH/register_config
    echo 0x17a20204 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a20224 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a20244 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a20264 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a20284 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a202a4 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a202c4 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a202e4 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a20400 12 > $MEM_DUMP_PATH/register_config
    echo 0x17a20450 24 > $MEM_DUMP_PATH/register_config
    echo 0x17a204a0 28 > $MEM_DUMP_PATH/register_config
    echo 0x17a20500 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a20600 512 > $MEM_DUMP_PATH/register_config
    echo 0x17a20d00 8 > $MEM_DUMP_PATH/register_config
    echo 0x17a20d10 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a20d30 320 > $MEM_DUMP_PATH/register_config
    echo 0x17a20fb0 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a20fd0 320 > $MEM_DUMP_PATH/register_config
    echo 0x17a21250 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a21270 320 > $MEM_DUMP_PATH/register_config
    echo 0x17a214f0 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a21510 320 > $MEM_DUMP_PATH/register_config
    echo 0x17a21790 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a217b0 320 > $MEM_DUMP_PATH/register_config
    echo 0x17a21a30 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a21a50 320 > $MEM_DUMP_PATH/register_config
    echo 0x17a21cd0 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a21cf0 320 > $MEM_DUMP_PATH/register_config
    echo 0x17a21f70 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a21f90 320 > $MEM_DUMP_PATH/register_config
    echo 0x17a23d44 4 > $MEM_DUMP_PATH/register_config
    echo 0x17a23d4c 8 > $MEM_DUMP_PATH/register_config
    echo 0x17a23e00 12 > $MEM_DUMP_PATH/register_config
    echo 0x17a30000 76 > $MEM_DUMP_PATH/register_config
    echo 0x17a30050 132 > $MEM_DUMP_PATH/register_config
    echo 0x17a300d8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17a30100 4 > $MEM_DUMP_PATH/register_config
    echo 0x17a30108 4 > $MEM_DUMP_PATH/register_config
    echo 0x17a30204 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a30224 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a30244 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a30264 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a30284 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a302a4 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a302c4 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a302e4 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a30400 12 > $MEM_DUMP_PATH/register_config
    echo 0x17a30450 24 > $MEM_DUMP_PATH/register_config
    echo 0x17a304a0 28 > $MEM_DUMP_PATH/register_config
    echo 0x17a30500 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a30600 512 > $MEM_DUMP_PATH/register_config
    echo 0x17a30d00 8 > $MEM_DUMP_PATH/register_config
    echo 0x17a30d10 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a30d30 320 > $MEM_DUMP_PATH/register_config
    echo 0x17a30fb0 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a30fd0 320 > $MEM_DUMP_PATH/register_config
    echo 0x17a31250 16 > $MEM_DUMP_PATH/register_config
    echo 0x17a31270 320 > $MEM_DUMP_PATH/register_config
    echo 0x17a33d44 4 > $MEM_DUMP_PATH/register_config
    echo 0x17a33d4c 8 > $MEM_DUMP_PATH/register_config
    echo 0x17a33e00 12 > $MEM_DUMP_PATH/register_config
    echo 0x17a80000 64 > $MEM_DUMP_PATH/register_config
    echo 0x17a82000 64 > $MEM_DUMP_PATH/register_config
    echo 0x17a84000 64 > $MEM_DUMP_PATH/register_config
    echo 0x17a86000 64 > $MEM_DUMP_PATH/register_config
    echo 0x17a8c000 24 > $MEM_DUMP_PATH/register_config
    echo 0x17a8e000 1024 > $MEM_DUMP_PATH/register_config
    echo 0x17a90000 41 > $MEM_DUMP_PATH/register_config
    echo 0x17a900ac 2 > $MEM_DUMP_PATH/register_config
    echo 0x17a900cc 41 > $MEM_DUMP_PATH/register_config
    echo 0x17a90080 9 > $MEM_DUMP_PATH/register_config
    echo 0x17a900ac 2 > $MEM_DUMP_PATH/register_config
    echo 0x17a900cc 57 > $MEM_DUMP_PATH/register_config
    echo 0x17a92000 41 > $MEM_DUMP_PATH/register_config
    echo 0x17a920ac 2 > $MEM_DUMP_PATH/register_config
    echo 0x17a920cc 41 > $MEM_DUMP_PATH/register_config
    echo 0x17a92080 9 > $MEM_DUMP_PATH/register_config
    echo 0x17a920ac 2 > $MEM_DUMP_PATH/register_config
    echo 0x17a920cc 57 > $MEM_DUMP_PATH/register_config
    echo 0x17a94000 41 > $MEM_DUMP_PATH/register_config
    echo 0x17a940ac 2 > $MEM_DUMP_PATH/register_config
    echo 0x17a940cc 41 > $MEM_DUMP_PATH/register_config
    echo 0x17a94080 9 > $MEM_DUMP_PATH/register_config
    echo 0x17a940ac 2 > $MEM_DUMP_PATH/register_config
    echo 0x17a940cc 57 > $MEM_DUMP_PATH/register_config
    echo 0x17a96000 41 > $MEM_DUMP_PATH/register_config
    echo 0x17a960ac 2 > $MEM_DUMP_PATH/register_config
    echo 0x17a960cc 41 > $MEM_DUMP_PATH/register_config
    echo 0x17a96080 9 > $MEM_DUMP_PATH/register_config
    echo 0x17a960ac 2 > $MEM_DUMP_PATH/register_config
    echo 0x17a960cc 57 > $MEM_DUMP_PATH/register_config
    echo 0x17aa0000 176 > $MEM_DUMP_PATH/register_config
    echo 0x17aa00fc 64 > $MEM_DUMP_PATH/register_config
    echo 0x17aa0200 8 > $MEM_DUMP_PATH/register_config
    echo 0x17aa0300 4 > $MEM_DUMP_PATH/register_config
    echo 0x17aa0400 4 > $MEM_DUMP_PATH/register_config
    echo 0x17aa0500 4 > $MEM_DUMP_PATH/register_config
    echo 0x17aa0600 4 > $MEM_DUMP_PATH/register_config
    echo 0x17aa0700 20 > $MEM_DUMP_PATH/register_config
    echo 0x17b00000 280 > $MEM_DUMP_PATH/register_config
    echo 0x17b70000 12 > $MEM_DUMP_PATH/register_config
    echo 0x17b70010 52 > $MEM_DUMP_PATH/register_config
    echo 0x17b70100 12 > $MEM_DUMP_PATH/register_config
    echo 0x17b70190 12 > $MEM_DUMP_PATH/register_config
    echo 0x17b70220 8 > $MEM_DUMP_PATH/register_config
    echo 0x17b702a0 8 > $MEM_DUMP_PATH/register_config
    echo 0x17b70320 4 > $MEM_DUMP_PATH/register_config
    echo 0x17b70380 52 > $MEM_DUMP_PATH/register_config
    echo 0x17b70410 52 > $MEM_DUMP_PATH/register_config
    echo 0x17b704a0 48 > $MEM_DUMP_PATH/register_config
    echo 0x17b70520 8 > $MEM_DUMP_PATH/register_config
    echo 0x17b70580 24 > $MEM_DUMP_PATH/register_config
    echo 0x17b70600 52 > $MEM_DUMP_PATH/register_config
    echo 0x17b70690 48 > $MEM_DUMP_PATH/register_config
    echo 0x17b70710 48 > $MEM_DUMP_PATH/register_config
    echo 0x17b70790 48 > $MEM_DUMP_PATH/register_config
    echo 0x17b70810 48 > $MEM_DUMP_PATH/register_config
    echo 0x17b70890 48 > $MEM_DUMP_PATH/register_config
    echo 0x17b70910 48 > $MEM_DUMP_PATH/register_config
    echo 0x17b70990 48 > $MEM_DUMP_PATH/register_config
    echo 0x17b70a10 48 > $MEM_DUMP_PATH/register_config
    echo 0x17b70a90 48 > $MEM_DUMP_PATH/register_config
    echo 0x17b70b00 52 > $MEM_DUMP_PATH/register_config
    echo 0x17b70b90 48 > $MEM_DUMP_PATH/register_config
    echo 0x17b70c10 48 > $MEM_DUMP_PATH/register_config
    echo 0x17b70c90 48 > $MEM_DUMP_PATH/register_config
    echo 0x17b70d10 48 > $MEM_DUMP_PATH/register_config
    echo 0x17b70d90 48 > $MEM_DUMP_PATH/register_config
    echo 0x17b70e00 44 > $MEM_DUMP_PATH/register_config
    echo 0x17b70e90 40 > $MEM_DUMP_PATH/register_config
    echo 0x17b70f10 40 > $MEM_DUMP_PATH/register_config
    echo 0x17b70f90 40 > $MEM_DUMP_PATH/register_config
    echo 0x17b71010 40 > $MEM_DUMP_PATH/register_config
    echo 0x17b71090 40 > $MEM_DUMP_PATH/register_config
    echo 0x17b71100 644 > $MEM_DUMP_PATH/register_config
    echo 0x17b71b00 8 > $MEM_DUMP_PATH/register_config
    echo 0x17b71b10 52 > $MEM_DUMP_PATH/register_config
    echo 0x17b71bb0 40 > $MEM_DUMP_PATH/register_config
    echo 0x17b71c40 92 > $MEM_DUMP_PATH/register_config
    echo 0x17b78000 12 > $MEM_DUMP_PATH/register_config
    echo 0x17b78010 16 > $MEM_DUMP_PATH/register_config
    echo 0x17b78090 20 > $MEM_DUMP_PATH/register_config
    echo 0x17b78100 12 > $MEM_DUMP_PATH/register_config
    echo 0x17b78190 12 > $MEM_DUMP_PATH/register_config
    echo 0x17b78220 8 > $MEM_DUMP_PATH/register_config
    echo 0x17b782a0 8 > $MEM_DUMP_PATH/register_config
    echo 0x17b78320 4 > $MEM_DUMP_PATH/register_config
    echo 0x17b78380 52 > $MEM_DUMP_PATH/register_config
    echo 0x17b78410 52 > $MEM_DUMP_PATH/register_config
    echo 0x17b784a0 48 > $MEM_DUMP_PATH/register_config
    echo 0x17b78520 8 > $MEM_DUMP_PATH/register_config
    echo 0x17b78580 24 > $MEM_DUMP_PATH/register_config
    echo 0x17b78600 324 > $MEM_DUMP_PATH/register_config
    echo 0x17b78b00 196 > $MEM_DUMP_PATH/register_config
    echo 0x17b78e00 28 > $MEM_DUMP_PATH/register_config
    echo 0x17b78e90 24 > $MEM_DUMP_PATH/register_config
    echo 0x17b78f10 24 > $MEM_DUMP_PATH/register_config
    echo 0x17b78f90 24 > $MEM_DUMP_PATH/register_config
    echo 0x17b79010 24 > $MEM_DUMP_PATH/register_config
    echo 0x17b79090 24 > $MEM_DUMP_PATH/register_config
    echo 0x17b79100 20 > $MEM_DUMP_PATH/register_config
    echo 0x17b79190 16 > $MEM_DUMP_PATH/register_config
    echo 0x17b79210 256 > $MEM_DUMP_PATH/register_config
    echo 0x17b79a10 16 > $MEM_DUMP_PATH/register_config
    echo 0x17b79a90 16 > $MEM_DUMP_PATH/register_config
    echo 0x17b79b00 8 > $MEM_DUMP_PATH/register_config
    echo 0x17b79b10 16 > $MEM_DUMP_PATH/register_config
    echo 0x17b79b90 20 > $MEM_DUMP_PATH/register_config
    echo 0x17b79bb0 16 > $MEM_DUMP_PATH/register_config
    echo 0x17b79c30 8 > $MEM_DUMP_PATH/register_config
    echo 0x17b79c40 16 > $MEM_DUMP_PATH/register_config
    echo 0x17b79cc0 60 > $MEM_DUMP_PATH/register_config
    echo 0x17b90000 24 > $MEM_DUMP_PATH/register_config
    echo 0x17b90020 20 > $MEM_DUMP_PATH/register_config
    echo 0x17b90050 4 > $MEM_DUMP_PATH/register_config
    echo 0x17b90070 104 > $MEM_DUMP_PATH/register_config
    echo 0x17b90100 4 > $MEM_DUMP_PATH/register_config
    echo 0x17b90120 4 > $MEM_DUMP_PATH/register_config
    echo 0x17b90140 4 > $MEM_DUMP_PATH/register_config
    echo 0x17b90200 48 > $MEM_DUMP_PATH/register_config
    echo 0x17b90700 4 > $MEM_DUMP_PATH/register_config
    echo 0x17b9070c 12 > $MEM_DUMP_PATH/register_config
    echo 0x17b90780 128 > $MEM_DUMP_PATH/register_config
    echo 0x17b90808 24 > $MEM_DUMP_PATH/register_config
    echo 0x17b90824 12 > $MEM_DUMP_PATH/register_config
    echo 0x17b90840 64 > $MEM_DUMP_PATH/register_config
    echo 0x17b90c48 24 > $MEM_DUMP_PATH/register_config
    echo 0x17b90c64 12 > $MEM_DUMP_PATH/register_config
    echo 0x17b90c80 64 > $MEM_DUMP_PATH/register_config
    echo 0x17b93500 320 > $MEM_DUMP_PATH/register_config
    echo 0x17b93a80 12 > $MEM_DUMP_PATH/register_config
    echo 0x17b93aa8 200 > $MEM_DUMP_PATH/register_config
    echo 0x17b93c00 20 > $MEM_DUMP_PATH/register_config
    echo 0x17b93c30 32 > $MEM_DUMP_PATH/register_config
    echo 0x17b93c60 8 > $MEM_DUMP_PATH/register_config
    echo 0x17b93c70 8 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0000 24 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0020 20 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0050 4 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0070 104 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0100 4 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0120 4 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0140 4 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0200 8 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0228 30 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0700 4 > $MEM_DUMP_PATH/register_config
    echo 0x17ba070c 12 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0780 128 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0808 24 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0824 12 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0840 64 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0c48 24 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0c64 12 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0c80 64 > $MEM_DUMP_PATH/register_config
    echo 0x17ba3500 320 > $MEM_DUMP_PATH/register_config
    echo 0x17ba3a80 12 > $MEM_DUMP_PATH/register_config
    echo 0x17ba3aa8 200 > $MEM_DUMP_PATH/register_config
    echo 0x17ba3c00 20 > $MEM_DUMP_PATH/register_config
    echo 0x17ba3c30 32 > $MEM_DUMP_PATH/register_config
    echo 0x17ba3c60 8 > $MEM_DUMP_PATH/register_config
    echo 0x17ba3c70 8 > $MEM_DUMP_PATH/register_config
    echo 0x17c000e8 260 > $MEM_DUMP_PATH/register_config
    echo 0x17c01000 472 > $MEM_DUMP_PATH/register_config
    echo 0x17c20000 12 > $MEM_DUMP_PATH/register_config
    echo 0x17c21000 12 > $MEM_DUMP_PATH/register_config
    echo 0x17d80000 12 > $MEM_DUMP_PATH/register_config
    echo 0x17d80010 8 > $MEM_DUMP_PATH/register_config
    echo 0x17d80100 1024 > $MEM_DUMP_PATH/register_config
    echo 0x17d90000 16 > $MEM_DUMP_PATH/register_config
    echo 0x17d90014 104 > $MEM_DUMP_PATH/register_config
    echo 0x17d90080 20 > $MEM_DUMP_PATH/register_config
    echo 0x17d900b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17d900b8 8 > $MEM_DUMP_PATH/register_config
    echo 0x17d900d0 36 > $MEM_DUMP_PATH/register_config
    echo 0x17d90100 160 > $MEM_DUMP_PATH/register_config
    echo 0x17d90200 160 > $MEM_DUMP_PATH/register_config
    echo 0x17d90300 20 > $MEM_DUMP_PATH/register_config
    echo 0x17d90320 4 > $MEM_DUMP_PATH/register_config
    echo 0x17d9034c 124 > $MEM_DUMP_PATH/register_config
    echo 0x17d903e0 8 > $MEM_DUMP_PATH/register_config
    echo 0x17d90404 4 > $MEM_DUMP_PATH/register_config
    echo 0x17d91000 16 > $MEM_DUMP_PATH/register_config
    echo 0x17d91014 104 > $MEM_DUMP_PATH/register_config
    echo 0x17d91080 32 > $MEM_DUMP_PATH/register_config
    echo 0x17d910b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17d910b8 8 > $MEM_DUMP_PATH/register_config
    echo 0x17d910d0 36 > $MEM_DUMP_PATH/register_config
    echo 0x17d91100 160 > $MEM_DUMP_PATH/register_config
    echo 0x17d91200 160 > $MEM_DUMP_PATH/register_config
    echo 0x17d91300 20 > $MEM_DUMP_PATH/register_config
    echo 0x17d91320 16 > $MEM_DUMP_PATH/register_config
    echo 0x17d9134c 140 > $MEM_DUMP_PATH/register_config
    echo 0x17d913e0 20 > $MEM_DUMP_PATH/register_config
    echo 0x17d91404 4 > $MEM_DUMP_PATH/register_config
    echo 0x17d92000 16 > $MEM_DUMP_PATH/register_config
    echo 0x17d92014 104 > $MEM_DUMP_PATH/register_config
    echo 0x17d92080 28 > $MEM_DUMP_PATH/register_config
    echo 0x17d920b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17d920b8 8 > $MEM_DUMP_PATH/register_config
    echo 0x17d920d0 36 > $MEM_DUMP_PATH/register_config
    echo 0x17d92100 160 > $MEM_DUMP_PATH/register_config
    echo 0x17d92200 160 > $MEM_DUMP_PATH/register_config
    echo 0x17d92300 20 > $MEM_DUMP_PATH/register_config
    echo 0x17d92320 12 > $MEM_DUMP_PATH/register_config
    echo 0x17d9234c 136 > $MEM_DUMP_PATH/register_config
    echo 0x17d923e0 16 > $MEM_DUMP_PATH/register_config
    echo 0x17d92404 4 > $MEM_DUMP_PATH/register_config
    echo 0x17d93000 16 > $MEM_DUMP_PATH/register_config
    echo 0x17d93014 104 > $MEM_DUMP_PATH/register_config
    echo 0x17d93080 20 > $MEM_DUMP_PATH/register_config
    echo 0x17d930b0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17d930b8 8 > $MEM_DUMP_PATH/register_config
    echo 0x17d930d0 36 > $MEM_DUMP_PATH/register_config
    echo 0x17d93100 160 > $MEM_DUMP_PATH/register_config
    echo 0x17d93200 160 > $MEM_DUMP_PATH/register_config
    echo 0x17d93300 20 > $MEM_DUMP_PATH/register_config
    echo 0x17d93320 4 > $MEM_DUMP_PATH/register_config
    echo 0x17d9334c 128 > $MEM_DUMP_PATH/register_config
    echo 0x17d933e0 8 > $MEM_DUMP_PATH/register_config
    echo 0x17d93404 4 > $MEM_DUMP_PATH/register_config
    echo 0x17d98000 40 > $MEM_DUMP_PATH/register_config
    echo 0x17e00000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e00008 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e00010 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e00018 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e00020 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e00028 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e00030 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e00038 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e00040 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e00048 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e00050 8 > $MEM_DUMP_PATH/register_config
    echo 0x17e10000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e10000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e10008 8 > $MEM_DUMP_PATH/register_config
    echo 0x17e10018 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e10020 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e10020 8 > $MEM_DUMP_PATH/register_config
    echo 0x17e10030 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e100f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e100f0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e100f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e100f8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e10100 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e10100 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e11000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e11000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e20000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e20008 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e20010 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e20018 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e20020 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e20028 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e20030 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e20038 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e20800 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e20808 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e20810 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e20e00 8 > $MEM_DUMP_PATH/register_config
    echo 0x17e20fa8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e20fbc 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e20fc8 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e20fd0 48 > $MEM_DUMP_PATH/register_config
    echo 0x17e30000 12 > $MEM_DUMP_PATH/register_config
    echo 0x17e30010 24 > $MEM_DUMP_PATH/register_config
    echo 0x17e30030 24 > $MEM_DUMP_PATH/register_config
    echo 0x17e30050 12 > $MEM_DUMP_PATH/register_config
    echo 0x17e30170 8 > $MEM_DUMP_PATH/register_config
    echo 0x17e30fb0 8 > $MEM_DUMP_PATH/register_config
    echo 0x17e30fc8 56 > $MEM_DUMP_PATH/register_config
    echo 0x17e80000 12 > $MEM_DUMP_PATH/register_config
    echo 0x17e80010 24 > $MEM_DUMP_PATH/register_config
    echo 0x17e80030 24 > $MEM_DUMP_PATH/register_config
    echo 0x17e80050 12 > $MEM_DUMP_PATH/register_config
    echo 0x17e80170 8 > $MEM_DUMP_PATH/register_config
    echo 0x17e80fb0 8 > $MEM_DUMP_PATH/register_config
    echo 0x17e80fc8 56 > $MEM_DUMP_PATH/register_config
    echo 0x17e90000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e90008 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e90010 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e90018 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e90100 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e90108 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e90110 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e90400 16 > $MEM_DUMP_PATH/register_config
    echo 0x17e90480 12 > $MEM_DUMP_PATH/register_config
    echo 0x17e90c00 16 > $MEM_DUMP_PATH/register_config
    echo 0x17e90ce0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17e90e00 12 > $MEM_DUMP_PATH/register_config
    echo 0x17e90fa8 8 > $MEM_DUMP_PATH/register_config
    echo 0x17e90fbc 12 > $MEM_DUMP_PATH/register_config
    echo 0x17e90fe0 32 > $MEM_DUMP_PATH/register_config
    echo 0x17eb0000 8 > $MEM_DUMP_PATH/register_config
    echo 0x17f80000 12 > $MEM_DUMP_PATH/register_config
    echo 0x17f80010 24 > $MEM_DUMP_PATH/register_config
    echo 0x17f80030 24 > $MEM_DUMP_PATH/register_config
    echo 0x17f80050 12 > $MEM_DUMP_PATH/register_config
    echo 0x17f80170 8 > $MEM_DUMP_PATH/register_config
    echo 0x17f80fb0 8 > $MEM_DUMP_PATH/register_config
    echo 0x17f80fc8 56 > $MEM_DUMP_PATH/register_config
    echo 0x17f90000 4 > $MEM_DUMP_PATH/register_config
    echo 0x17f90008 4 > $MEM_DUMP_PATH/register_config
    echo 0x17f90010 4 > $MEM_DUMP_PATH/register_config
    echo 0x17f90018 4 > $MEM_DUMP_PATH/register_config
    echo 0x17f90100 4 > $MEM_DUMP_PATH/register_config
    echo 0x17f90108 4 > $MEM_DUMP_PATH/register_config
    echo 0x17f90110 4 > $MEM_DUMP_PATH/register_config
    echo 0x17f90400 16 > $MEM_DUMP_PATH/register_config
    echo 0x17f90480 12 > $MEM_DUMP_PATH/register_config
    echo 0x17f90c00 16 > $MEM_DUMP_PATH/register_config
    echo 0x17f90ce0 4 > $MEM_DUMP_PATH/register_config
    echo 0x17f90e00 12 > $MEM_DUMP_PATH/register_config
    echo 0x17f90fa8 8 > $MEM_DUMP_PATH/register_config
    echo 0x17f90fbc 12 > $MEM_DUMP_PATH/register_config
    echo 0x17f90fe0 32 > $MEM_DUMP_PATH/register_config
    echo 0x17fb0000 8 > $MEM_DUMP_PATH/register_config
    echo 0x18080000 12 > $MEM_DUMP_PATH/register_config
    echo 0x18080010 24 > $MEM_DUMP_PATH/register_config
    echo 0x18080030 24 > $MEM_DUMP_PATH/register_config
    echo 0x18080050 12 > $MEM_DUMP_PATH/register_config
    echo 0x18080170 8 > $MEM_DUMP_PATH/register_config
    echo 0x18080fb0 8 > $MEM_DUMP_PATH/register_config
    echo 0x18080fc8 56 > $MEM_DUMP_PATH/register_config
    echo 0x18090000 4 > $MEM_DUMP_PATH/register_config
    echo 0x18090008 4 > $MEM_DUMP_PATH/register_config
    echo 0x18090010 4 > $MEM_DUMP_PATH/register_config
    echo 0x18090018 4 > $MEM_DUMP_PATH/register_config
    echo 0x18090100 4 > $MEM_DUMP_PATH/register_config
    echo 0x18090108 4 > $MEM_DUMP_PATH/register_config
    echo 0x18090110 4 > $MEM_DUMP_PATH/register_config
    echo 0x18090400 16 > $MEM_DUMP_PATH/register_config
    echo 0x18090480 12 > $MEM_DUMP_PATH/register_config
    echo 0x18090c00 16 > $MEM_DUMP_PATH/register_config
    echo 0x18090ce0 4 > $MEM_DUMP_PATH/register_config
    echo 0x18090e00 12 > $MEM_DUMP_PATH/register_config
    echo 0x18090fa8 8 > $MEM_DUMP_PATH/register_config
    echo 0x18090fbc 12 > $MEM_DUMP_PATH/register_config
    echo 0x18090fe0 32 > $MEM_DUMP_PATH/register_config
    echo 0x180b0000 8 > $MEM_DUMP_PATH/register_config
    echo 0x18180000 12 > $MEM_DUMP_PATH/register_config
    echo 0x18180010 24 > $MEM_DUMP_PATH/register_config
    echo 0x18180030 24 > $MEM_DUMP_PATH/register_config
    echo 0x18180050 12 > $MEM_DUMP_PATH/register_config
    echo 0x18180170 8 > $MEM_DUMP_PATH/register_config
    echo 0x18180fb0 8 > $MEM_DUMP_PATH/register_config
    echo 0x18180fc8 56 > $MEM_DUMP_PATH/register_config
    echo 0x18190000 4 > $MEM_DUMP_PATH/register_config
    echo 0x18190008 4 > $MEM_DUMP_PATH/register_config
    echo 0x18190010 4 > $MEM_DUMP_PATH/register_config
    echo 0x18190018 4 > $MEM_DUMP_PATH/register_config
    echo 0x18190100 4 > $MEM_DUMP_PATH/register_config
    echo 0x18190108 4 > $MEM_DUMP_PATH/register_config
    echo 0x18190110 4 > $MEM_DUMP_PATH/register_config
    echo 0x18190400 16 > $MEM_DUMP_PATH/register_config
    echo 0x18190480 12 > $MEM_DUMP_PATH/register_config
    echo 0x18190c00 16 > $MEM_DUMP_PATH/register_config
    echo 0x18190ce0 4 > $MEM_DUMP_PATH/register_config
    echo 0x18190e00 12 > $MEM_DUMP_PATH/register_config
    echo 0x18190fa8 8 > $MEM_DUMP_PATH/register_config
    echo 0x18190fbc 12 > $MEM_DUMP_PATH/register_config
    echo 0x18190fe0 32 > $MEM_DUMP_PATH/register_config
    echo 0x181b0000 8 > $MEM_DUMP_PATH/register_config
    echo 0x18280000 12 > $MEM_DUMP_PATH/register_config
    echo 0x18280010 24 > $MEM_DUMP_PATH/register_config
    echo 0x18280030 24 > $MEM_DUMP_PATH/register_config
    echo 0x18280050 12 > $MEM_DUMP_PATH/register_config
    echo 0x18280170 8 > $MEM_DUMP_PATH/register_config
    echo 0x18280fb0 8 > $MEM_DUMP_PATH/register_config
    echo 0x18280fc8 56 > $MEM_DUMP_PATH/register_config
    echo 0x18290000 4 > $MEM_DUMP_PATH/register_config
    echo 0x18290008 4 > $MEM_DUMP_PATH/register_config
    echo 0x18290010 4 > $MEM_DUMP_PATH/register_config
    echo 0x18290018 4 > $MEM_DUMP_PATH/register_config
    echo 0x18290100 4 > $MEM_DUMP_PATH/register_config
    echo 0x18290108 4 > $MEM_DUMP_PATH/register_config
    echo 0x18290110 4 > $MEM_DUMP_PATH/register_config
    echo 0x18290400 16 > $MEM_DUMP_PATH/register_config
    echo 0x18290480 16 > $MEM_DUMP_PATH/register_config
    echo 0x18290c00 16 > $MEM_DUMP_PATH/register_config
    echo 0x18290ce0 4 > $MEM_DUMP_PATH/register_config
    echo 0x18290e00 12 > $MEM_DUMP_PATH/register_config
    echo 0x18290fa8 8 > $MEM_DUMP_PATH/register_config
    echo 0x18290fbc 12 > $MEM_DUMP_PATH/register_config
    echo 0x18290fe0 32 > $MEM_DUMP_PATH/register_config
    echo 0x18380000 12 > $MEM_DUMP_PATH/register_config
    echo 0x18380010 24 > $MEM_DUMP_PATH/register_config
    echo 0x18380030 24 > $MEM_DUMP_PATH/register_config
    echo 0x18380050 12 > $MEM_DUMP_PATH/register_config
    echo 0x18380170 8 > $MEM_DUMP_PATH/register_config
    echo 0x18380fb0 8 > $MEM_DUMP_PATH/register_config
    echo 0x18380fc8 56 > $MEM_DUMP_PATH/register_config
    echo 0x18390000 4 > $MEM_DUMP_PATH/register_config
    echo 0x18390008 4 > $MEM_DUMP_PATH/register_config
    echo 0x18390010 4 > $MEM_DUMP_PATH/register_config
    echo 0x18390018 4 > $MEM_DUMP_PATH/register_config
    echo 0x18390100 4 > $MEM_DUMP_PATH/register_config
    echo 0x18390108 4 > $MEM_DUMP_PATH/register_config
    echo 0x18390110 4 > $MEM_DUMP_PATH/register_config
    echo 0x18390400 16 > $MEM_DUMP_PATH/register_config
    echo 0x18390480 16 > $MEM_DUMP_PATH/register_config
    echo 0x18390c00 16 > $MEM_DUMP_PATH/register_config
    echo 0x18390ce0 4 > $MEM_DUMP_PATH/register_config
    echo 0x18390e00 12 > $MEM_DUMP_PATH/register_config
    echo 0x18390fa8 8 > $MEM_DUMP_PATH/register_config
    echo 0x18390fbc 12 > $MEM_DUMP_PATH/register_config
    echo 0x18390fe0 32 > $MEM_DUMP_PATH/register_config
    echo 0x18480000 12 > $MEM_DUMP_PATH/register_config
    echo 0x18480010 24 > $MEM_DUMP_PATH/register_config
    echo 0x18480030 24 > $MEM_DUMP_PATH/register_config
    echo 0x18480050 12 > $MEM_DUMP_PATH/register_config
    echo 0x18480170 8 > $MEM_DUMP_PATH/register_config
    echo 0x18480fb0 8 > $MEM_DUMP_PATH/register_config
    echo 0x18480fc8 56 > $MEM_DUMP_PATH/register_config
    echo 0x18490000 4 > $MEM_DUMP_PATH/register_config
    echo 0x18490008 4 > $MEM_DUMP_PATH/register_config
    echo 0x18490010 4 > $MEM_DUMP_PATH/register_config
    echo 0x18490018 4 > $MEM_DUMP_PATH/register_config
    echo 0x18490100 4 > $MEM_DUMP_PATH/register_config
    echo 0x18490108 4 > $MEM_DUMP_PATH/register_config
    echo 0x18490110 4 > $MEM_DUMP_PATH/register_config
    echo 0x18490400 16 > $MEM_DUMP_PATH/register_config
    echo 0x18490480 16 > $MEM_DUMP_PATH/register_config
    echo 0x18490c00 16 > $MEM_DUMP_PATH/register_config
    echo 0x18490ce0 4 > $MEM_DUMP_PATH/register_config
    echo 0x18490e00 12 > $MEM_DUMP_PATH/register_config
    echo 0x18490fa8 8 > $MEM_DUMP_PATH/register_config
    echo 0x18490fbc 12 > $MEM_DUMP_PATH/register_config
    echo 0x18490fe0 32 > $MEM_DUMP_PATH/register_config
    echo 0x18580000 12 > $MEM_DUMP_PATH/register_config
    echo 0x18580010 24 > $MEM_DUMP_PATH/register_config
    echo 0x18580030 24 > $MEM_DUMP_PATH/register_config
    echo 0x18580050 12 > $MEM_DUMP_PATH/register_config
    echo 0x18580170 8 > $MEM_DUMP_PATH/register_config
    echo 0x18580fb0 8 > $MEM_DUMP_PATH/register_config
    echo 0x18580fc8 56 > $MEM_DUMP_PATH/register_config
    echo 0x18590000 4 > $MEM_DUMP_PATH/register_config
    echo 0x18590008 4 > $MEM_DUMP_PATH/register_config
    echo 0x18590010 4 > $MEM_DUMP_PATH/register_config
    echo 0x18590018 4 > $MEM_DUMP_PATH/register_config
    echo 0x18590100 4 > $MEM_DUMP_PATH/register_config
    echo 0x18590108 4 > $MEM_DUMP_PATH/register_config
    echo 0x18590110 4 > $MEM_DUMP_PATH/register_config
    echo 0x18590400 16 > $MEM_DUMP_PATH/register_config
    echo 0x18590480 16 > $MEM_DUMP_PATH/register_config
    echo 0x18590c00 16 > $MEM_DUMP_PATH/register_config
    echo 0x18590ce0 4 > $MEM_DUMP_PATH/register_config
    echo 0x18590e00 12 > $MEM_DUMP_PATH/register_config
    echo 0x18590fa8 8 > $MEM_DUMP_PATH/register_config
    echo 0x18590fbc 12 > $MEM_DUMP_PATH/register_config
    echo 0x18590fe0 32 > $MEM_DUMP_PATH/register_config
    echo 0x17d00000 65536 > $MEM_DUMP_PATH/register_config

}

create_stp_policy()
{
    mkdir /config/stp-policy/coresight-stm:p_ost.policy
    chmod 660 /config/stp-policy/coresight-stm:p_ost.policy
    mkdir /config/stp-policy/coresight-stm:p_ost.policy/default
    chmod 660 /config/stp-policy/coresight-stm:p_ost.policy/default
    echo 0x10 > /sys/bus/coresight/devices/coresight-stm/traceid
}

#function to enable cti flush for etf
enable_cti_flush_for_etf()
{
    # bail out if its perf config
    if [ ! -d /sys/module/msm_rtb ]
    then
        return
    fi

    echo 1 >/sys/bus/coresight/devices/coresight-cti-swao_cti/enable
    echo 0 24 >/sys/bus/coresight/devices/coresight-cti-swao_cti/channels/trigin_attach
    echo 0 1 >/sys/bus/coresight/devices/coresight-cti-swao_cti/channels/trigout_attach
}

ftrace_disable=`getprop persist.debug.ftrace_events_disable`
coresight_config=`getprop persist.debug.coresight.config`
tracefs=/sys/kernel/tracing
srcenable="enable"
enable_debug()
{
    echo "taro debug"
    etr_size="0x2000000"
    srcenable="enable_source"
    sinkenable="enable_sink"
    create_stp_policy
    echo "Enabling STM events on taro."
    adjust_permission
    enable_stm_events
    enable_cti_flush_for_etf
    #enable_lpm_with_dcvs_tracing
    if [ "$ftrace_disable" != "Yes" ]; then
        enable_ftrace_event_tracing
    fi
    # removing core hang config from postboot as core hang detection is enabled from sysini
    # enable_core_hang_config
    enable_dcc
    enable_cpuss_hw_events
    enable_schedstats
    setprop ro.dbg.coresight.stm_cfg_done 1
    enable_cpuss_register
    enable_memory_debug
    if [ -d $tracefs ] && [ "$(getprop persist.vendor.tracing.enabled)" -eq "1" ]; then
        mkdir $tracefs/instances/hsuart
        #UART
        echo 800 > $tracefs/instances/hsuart/buffer_size_kb
        echo 1 > $tracefs/instances/hsuart/events/serial/enable
        echo 1 > $tracefs/instances/hsuart/tracing_on

        #SPI
        mkdir $tracefs/instances/spi_qup
        echo 1 > $tracefs/instances/spi_qup/events/qup_spi_trace/enable
        echo 1 > $tracefs/instances/spi_qup/tracing_on

        #I2C
        mkdir $tracefs/instances/i2c_qup
        echo 1 > $tracefs/instances/i2c_qup/events/qup_i2c_trace/enable
        echo 1 > $tracefs/instances/i2c_qup/tracing_on

        #GENI_COMMON
        mkdir $tracefs/instances/qupv3_common
        echo 1 > $tracefs/instances/qupv3_common/events/qup_common_trace/enable
        echo 1 > $tracefs/instances/qupv3_common/tracing_on

        #SLIMBUS
        mkdir $tracefs/instances/slimbus
        echo 1 > $tracefs/instances/slimbus/events/slimbus/slimbus_dbg/enable
        echo 1 > $tracefs/instances/slimbus/tracing_on
    fi
}



enable_debug
