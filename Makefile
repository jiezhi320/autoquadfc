PROJ:=aq_gcc_v7.0_hwv
TARGET:=$(PROJ)
TOOLCHAIN_ROOT:=/opt/gcc-arm-none-eabi
TOOLCHAIN_PATH:=$(TOOLCHAIN_ROOT)/bin
TOOLCHAIN_PREFIX:=arm-none-eabi

CC=$(TOOLCHAIN_PATH)/$(TOOLCHAIN_PREFIX)-gcc
LD=$(TOOLCHAIN_PATH)/$(TOOLCHAIN_PREFIX)-gcc
OBJCOPY=$(TOOLCHAIN_PATH)/$(TOOLCHAIN_PREFIX)-objcopy
AS=$(TOOLCHAIN_PATH)/$(TOOLCHAIN_PREFIX)-as
AR=$(TOOLCHAIN_PATH)/$(TOOLCHAIN_PREFIX)-ar
GDB=$(TOOLCHAIN_PATH)/$(TOOLCHAIN_PREFIX)-gdb

PROJ_ROOT=$(CURDIR)

STARTUP:=$(PROJ_ROOT)/stm32
LINKER_SCRIPT:=$(PROJ_ROOT)/stm32/stm32f40x_flash.ld

BRD_VER:=8
BRD_REV:=6
TARGET:=$(PROJ)$(BRD_VER).$(BRD_REV)

BUILD_TYPE?=Release

ifeq ($(findstring Debug, $(BUILD_TYPE)), Debug)
BUILD_TYPE=Debug
BUILD_DIR=$(PROJ_ROOT)/build/Debug/obj
BIN_DIR=$(PROJ_ROOT)/build/Debug/bin
OPTLVL=0
DBG=-g3
else
BUILD_DIR=$(PROJ_ROOT)/build/Release/obj
BIN_DIR=$(PROJ_ROOT)/build/Release/bin
OPTLVL=2
DBG=
endif

INCLUDE=-I$(PROJ_ROOT)/stm32
INCLUDE+=-I$(PROJ_ROOT)/utils
INCLUDE+=-I$(PROJ_ROOT)/Libraries/CMSIS
INCLUDE+=-I$(PROJ_ROOT)/Libraries/mavlink/include/autoquad
INCLUDE+=-I$(PROJ_ROOT)/Libraries/StdPeriphDriver/inc
INCLUDE+=-I$(PROJ_ROOT)/onboard/actuator
INCLUDE+=-I$(PROJ_ROOT)/onboard/BSP/USB
INCLUDE+=-I$(PROJ_ROOT)/onboard/BSP/CAN
INCLUDE+=-I$(PROJ_ROOT)/onboard/BSP
INCLUDE+=-I$(PROJ_ROOT)/onboard/config
INCLUDE+=-I$(PROJ_ROOT)/onboard/CoOS
INCLUDE+=-I$(PROJ_ROOT)/onboard/FatFs
INCLUDE+=-I$(PROJ_ROOT)/onboard/logger
INCLUDE+=-I$(PROJ_ROOT)/onboard/math
INCLUDE+=-I$(PROJ_ROOT)/onboard/misc/signaling
INCLUDE+=-I$(PROJ_ROOT)/onboard/radio
INCLUDE+=-I$(PROJ_ROOT)/onboard/radio/DSM
INCLUDE+=-I$(PROJ_ROOT)/onboard/run
INCLUDE+=-I$(PROJ_ROOT)/onboard/targets
INCLUDE+=-I$(PROJ_ROOT)/onboard/telemetry
INCLUDE+=-I$(PROJ_ROOT)/onboard
INCLUDE+=-I$(PROJ_ROOT)/onboard/INS/control
INCLUDE+=-I$(PROJ_ROOT)/onboard/INS/GPS
INCLUDE+=-I$(PROJ_ROOT)/onboard/INS/IMU/analog
INCLUDE+=-I$(PROJ_ROOT)/onboard/INS/IMU/digital
INCLUDE+=-I$(PROJ_ROOT)/onboard/INS/IMU
INCLUDE+=-I$(PROJ_ROOT)/onboard/INS/navigation

SRC_DIR=$(PROJ_ROOT)/stm32
SRC_DIR+=$(PROJ_ROOT)/utils
SRC_DIR+=$(PROJ_ROOT)/Libraries/DSPLib
SRC_DIR+=$(PROJ_ROOT)/Libraries/StdPeriphDriver/src
SRC_DIR+=$(PROJ_ROOT)/onboard/actuator
SRC_DIR+=$(PROJ_ROOT)/onboard/BSP/USB
SRC_DIR+=$(PROJ_ROOT)/onboard/BSP/CAN
SRC_DIR+=$(PROJ_ROOT)/onboard/BSP
SRC_DIR+=$(PROJ_ROOT)/onboard/config
SRC_DIR+=$(PROJ_ROOT)/onboard/CoOS
SRC_DIR+=$(PROJ_ROOT)/onboard/FatFs
SRC_DIR+=$(PROJ_ROOT)/onboard/logger
SRC_DIR+=$(PROJ_ROOT)/onboard/math
SRC_DIR+=$(PROJ_ROOT)/onboard/misc/signaling
SRC_DIR+=$(PROJ_ROOT)/onboard/radio
SRC_DIR+=$(PROJ_ROOT)/onboard/radio/DSM
SRC_DIR+=$(PROJ_ROOT)/onboard/run
SRC_DIR+=$(PROJ_ROOT)/onboard/telemetry
SRC_DIR+=$(PROJ_ROOT)/onboard
SRC_DIR+=$(PROJ_ROOT)/onboard/INS/control
SRC_DIR+=$(PROJ_ROOT)/onboard/INS/GPS
SRC_DIR+=$(PROJ_ROOT)/onboard/INS/IMU/analog
SRC_DIR+=$(PROJ_ROOT)/onboard/INS/IMU/digital
SRC_DIR+=$(PROJ_ROOT)/onboard/INS/IMU
SRC_DIR+=$(PROJ_ROOT)/onboard/INS/navigation

vpath %.c $(SRC_DIR)
vpath %.s $(STARTUP)

# Startup file
ASRC=startup_stm32f4xx.s

# Project Source Files
SRC=main.c
SRC+=esc32.c
SRC+=gimbal.c
SRC+=motors.c
SRC+=pwm.c
SRC+=1wire.c
SRC+=analog.c
SRC+=aq_timer.c
SRC+=can.c
SRC+=canCalib.c
SRC+=canOSD.c
SRC+=canSensors.c
SRC+=canUart.c
SRC+=digital.c
SRC+=ext_irq.c
SRC+=fpu.c
SRC+=rcc.c
SRC+=rtc.c
SRC+=sdio.c
SRC+=serial.c
SRC+=spi.c
SRC+=usb.c
SRC+=usbd_cdc_msc_core.c
SRC+=usbd_core.c
SRC+=usbd_desc.c
SRC+=usbd_ioreq.c
SRC+=usbd_msc_bot.c
SRC+=usbd_msc_data.c
SRC+=usbd_msc_scsi.c
SRC+=usbd_req.c
SRC+=usbd_storage_msd.c
SRC+=usb_bsp.c
SRC+=usb_core.c
SRC+=usb_dcd.c
SRC+=usb_dcd_int.c
SRC+=util.c
SRC+=config.c
SRC+=flash.c
SRC+=arch.c
SRC+=core.c
SRC+=event.c
SRC+=flag.c
SRC+=kernelHeap.c
SRC+=mbox.c
SRC+=mm.c
SRC+=mutex.c
SRC+=port.c
SRC+=queue.c
SRC+=sem.c
SRC+=serviceReq.c
SRC+=task.c
SRC+=time.c
SRC+=timer.c
SRC+=utility.c
SRC+=ff.c
SRC+=control.c
SRC+=pid.c
SRC+=gps.c
SRC+=ublox.c
SRC+=adc.c
SRC+=d_imu.c
SRC+=eeprom.c
SRC+=hmc5983.c
SRC+=max21100.c
SRC+=mpu6000.c
SRC+=ms5611.c
SRC+=imu.c
SRC+=alt_ukf.c
SRC+=nav.c
SRC+=nav_ukf.c
SRC+=filer.c
SRC+=logger.c
SRC+=algebra.c
SRC+=calib.c
SRC+=compass.c
SRC+=rotations.c
SRC+=srcdkf.c
SRC+=signaling.c
SRC+=cyrf6936.c
SRC+=dsm.c
SRC+=futaba.c
SRC+=grhott.c
SRC+=mlinkrx.c
SRC+=ppm.c
SRC+=radio.c
SRC+=spektrum.c
SRC+=aq_init.c
SRC+=run.c
SRC+=supervisor.c
SRC+=aq_mavlink.c
SRC+=comm.c
SRC+=command.c
SRC+=telemetry.c
SRC+=getbuildnum.c

# DSP library
SRC+=arm_copy_f32.c
SRC+=arm_mat_init_f32.c
SRC+=arm_mat_sub_f32.c
SRC+=arm_scale_f32.c
SRC+=arm_fill_f32.c
SRC+=arm_mat_inverse_f32.c
SRC+=arm_mat_trans_f32.c
SRC+=arm_std_f32.c
SRC+=arm_mat_add_f32.c
SRC+=arm_mat_mult_f32.c
SRC+=arm_mean_f32.c

SRC+=system_stm32f4xx.c
SRC+=syscalls.c

# Standard Peripheral Source Files
SRC+=misc.c
# SRC+=stm32f4xx_dac.c
# SRC+=stm32f4xx_fmc.c
# SRC+=stm32f4xx_lptim.c
# SRC+=stm32f4xx_spdifrx.c
SRC+=stm32f4xx_adc.c
SRC+=stm32f4xx_dbgmcu.c
# SRC+=stm32f4xx_fmpi2c.c
# SRC+=stm32f4xx_ltdc.c
SRC+=stm32f4xx_spi.c
SRC+=stm32f4xx_can.c
# SRC+=stm32f4xx_dcmi.c
# SRC+=stm32f4xx_fsmc.c
SRC+=stm32f4xx_pwr.c
SRC+=stm32f4xx_syscfg.c
# SRC+=stm32f4xx_cec.c
SRC+=stm32f4xx_dma.c
SRC+=stm32f4xx_gpio.c
# SRC+=stm32f4xx_qspi.c
SRC+=stm32f4xx_tim.c
# SRC+=stm32f4xx_crc.c
# SRC+=stm32f4xx_dma2d.c
# SRC+=stm32f4xx_hash.c
SRC+=stm32f4xx_rcc.c
SRC+=stm32f4xx_usart.c
# SRC+=stm32f4xx_cryp.c
# SRC+=stm32f4xx_dsi.c
# SRC+=stm32f4xx_hash_md5.c
# SRC+=stm32f4xx_rng.c
# SRC+=stm32f4xx_wwdg.c
# SRC+=stm32f4xx_cryp_aes.c
SRC+=stm32f4xx_exti.c
# SRC+=stm32f4xx_hash_sha1.c
SRC+=stm32f4xx_rtc.c
# SRC+=stm32f4xx_cryp_des.c
SRC+=stm32f4xx_flash.c
# SRC+=stm32f4xx_i2c.c
# SRC+=stm32f4xx_sai.c
# SRC+=stm32f4xx_cryp_tdes.c
# SRC+=stm32f4xx_flash_ramfunc.c
# SRC+=stm32f4xx_iwdg.c
SRC+=stm32f4xx_sdio.c

CDEFS=-DUSE_STDPERIPH_DRIVER
CDEFS+=-DSTM32F4XX
CDEFS+=-DSTM32F40_41xxx
CDEFS+=-DHSE_VALUE=25000000
CDEFS+=-D__FPU_PRESENT=1
CDEFS+=-D__FPU_USED=1
CDEFS+=-DARM_MATH_CM4
CDEFS+=-DBOARD_VERSION=$(BRD_VER)
CDEFS+=-DBOARD_REVISION=$(BRD_REV)

MCUFLAGS=-mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 -fsingle-precision-constant -finline-functions -Wdouble-promotion -std=gnu99
COMMONFLAGS=-O$(OPTLVL) $(DBG) -Wall
CFLAGS=$(COMMONFLAGS) $(MCUFLAGS) $(INCLUDE) $(CDEFS)

LDLIBS=-lm -lc -lgcc
LDFLAGS=$(MCUFLAGS) -u _scanf_float -u _printf_float -fno-exceptions -ffunction-sections -fdata-sections -Wl,--gc-sections,-T$(LINKER_SCRIPT)

OBJ = $(SRC:%.c=$(BUILD_DIR)/%.o)

$(BUILD_DIR)/%.o: %.c dirs
	@echo [CC] $(notdir $<)
	@$(CC) $(CFLAGS) $< -c -o $@

all: $(OBJ)
	@echo [AS] $(notdir $(STARTUP)/$(ASRC))
	@$(AS) -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -o $(ASRC:%.s=$(BUILD_DIR)/%.o) $(STARTUP)/$(ASRC)
	@echo [LD] $(notdir $(BIN_DIR)/$(TARGET).elf)
	@$(LD) $(LDFLAGS) -o $(BIN_DIR)/$(TARGET).elf $(OBJ) $(ASRC:%.s=$(BUILD_DIR)/%.o) $(LDLIBS)
	@echo [HEX] $(notdir $(BIN_DIR)/$(TARGET).hex)
	@$(OBJCOPY) -O ihex $(BIN_DIR)/$(TARGET).elf $(BIN_DIR)/$(TARGET).hex
	@echo [BIN] $(notdir $(BIN_DIR)/$(TARGET).bin)
	@$(OBJCOPY) -O binary $(BIN_DIR)/$(TARGET).elf $(BIN_DIR)/$(TARGET).bin

dirs:
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(BIN_DIR)

.PHONY: clean

clean:
	@echo [RM] Objects
	@rm -f $(OBJ)
	@rm -f $(ASRC:%.s=$(BUILD_DIR)/%.o)
	@echo [RM] Binaries
	@rm -f $(BIN_DIR)/$(TARGET).elf
	@rm -f $(BIN_DIR)/$(TARGET).hex
	@rm -f $(BIN_DIR)/$(TARGET).bin

swd: all
	@st-flash --reset write $(BIN_DIR)/$(TARGET).bin 0x8000000

sfl: all
	@stm32flash -b 115200 -w $(BIN_DIR)/$(TARGET).bin -s 0x08000000 -v /dev/ttyUSB1

reflash: clean swd
