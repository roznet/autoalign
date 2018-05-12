SRC_DIR=src
BUILD_DIR=obj
TARGET_DIR=bin
LIB=

ALIGN_SRC=$(SRC_DIR)/align_main.cpp
ALIGN_FLEXSRC=$(SRC_DIR)/align_tokenize.lpp
ALIGN_BISONSRC=$(SRC_DIR)/align_grammar.ypp
ALIGN_OBJS=$(patsubst $(SRC_DIR)/%,$(BUILD_DIR)/%,$(ALIGN_SRC:.cpp=.o) $(ALIGN_BISONSRC:.ypp=.o) $(ALIGN_FLEXSRC:.lpp=.o))
ALIGN_DEPS=$(ALIGN_OBJS:.o=.d)

FLEXSRC=$(ALIGN_FLEXSRC)
BISONSRC=$(ALIGN_BISONSRC)

DEPS=$(ALIGN_DEPS)

INTERMEDIARIES=$(patsubst $(SRC_DIR)/%,$(BUILD_DIR)/%,$(FLEXSRC:.lpp=.cpp) $(BISONSRC:.ypp=.cpp) $(BISONSRC:.ypp=.hpp))

CXX=clang++
IFLAGS=-I$(BUILD_DIR) -I$(SRC_DIR)
CFLAGS=-g 
CPPFLAGS=-g -std=c++11 $(IFLAGS)
FLEX=flex
FFLAGS=
BISON=bison

$(BUILD_DIR)/%.cpp: $(SRC_DIR)/%.ypp
	$(BISON) -o $@ -d $< 

$(BUILD_DIR)/%.cpp: $(SRC_DIR)/%.lpp
	flex -o $@ $<

$(BUILD_DIR)/%.d: $(SRC_DIR)/%.cpp
	$(CXX) $(CPPFLAGS) -MMD -MF $@ -c $^

$(BUILD_DIR)/%.d: $(BUILD_DIR)/%.cpp
	$(CXX) $(CPPFLAGS) -MMD -MF $@ -c $^

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(CPPFLAGS) -c $< -o $@

all: directories $(TARGET_DIR)/align

.PHONY: directories
directories:
	mkdir -p $(BUILD_DIR)
	mkdir -p $(TARGET_DIR)

$(TARGET_DIR)/align: $(ALIGN_OBJS)
	$(CXX) $(CPPFLAGS) -o $@ $(ALIGN_OBJS)

.PHONY: clean
clean:
	rm -fr $(TARGET_DIR)  $(BUILD_DIR)

.PHONY: depend
depend: $(DEPS)
	@echo Depend: $(DEPS)

-include $(DEPS)
