
ALIGN_SRC=align_main.cpp
ALIGN_FLEXSRC=align_tokenize.flex
ALIGN_BISONSRC=align_grammar.ypp
ALIGN_OBJS=$(ALIGN_SRC:.cpp=.o) $(ALIGN_FLEXSRC:.flex=.o) $(ALIGN_BISONSRC:.ypp=.o)
ALIGN_DEPS=$(ALIGN_OBJS:.o=.d)


FLEXSRC=$(ALIGN_FLEXSRC)
BISONSRC=$(ALIGN_BISONSRC)

DEPS=$(ALIGN_DEPS)

INTERMEDIARIES=$(FLEXSRC:.flex=.cpp) $(BISONSRC:.ypp=.cpp) $(BISONSRC:.ypp=.hpp)

CXX=clang++
CFLAGS=-g 
CPPFLAGS=-g -std=c++11
FLEX=flex
FFLAGS=
BISON=bison

%.cpp: %.ypp
	$(BISON) -o $@ -d $< 

%.cpp: %.flex
	flex -o $@ $<

%.d: %.cpp
	$(CXX) $(CPPFLAGS) -MMD -MF $@ -c $^

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.cpp
	$(CXX) $(CPPFLAGS) -c $< -o $@

all:  align

align: $(ALIGN_OBJS)
	$(CXX) $(CPPFLAGS) -o $@ $(ALIGN_OBJS)

.PHONY: clean
clean:
	rm -fr align *.o *~ *.d align.dSYM $(INTERMEDIARIES)


.PHONY: depend
depend: $(DEPS)
	@echo Depend: $(DEPS)

include $(DEPS)
