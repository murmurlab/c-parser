CC				= c++

LXXFLAGS		= 
RUNFLAGS		=

EXE_DIR			= 
ROOT			= cparser/
NAME			= c-parser
TEST			= c-test
LIB				= $(ROOT)/lib
CMD_DIR			= $(ROOT)/cmd
SRC_DIR			= $(ROOT)/src
INC_DIR			= $(ROOT)/inc
OBJ_DIR			= .
SRCS			= $(wildcard $(SRC_DIR)/*.cpp)
OBJS			= $(SRCS:%.cpp=%.o)
CMD_CPARSER		= $(CMD_DIR)/$(NAME).o
CMD_CTEST		= $(CMD_DIR)/$(TEST).o
CMDS			= $(CMD_CPARSER) $(CMD_CTEST)
DEPENDENCIES	=

CXXFLAGS        = -Wc99-designator -std=c++98 -pedantic -I $(INC_DIR)

os =  ${shell uname -s}
ifeq '$(os)' 'Darwin'
NPROCS  = $(shell sysctl -n hw.ncpu)
else ifeq '$(os)' 'Linux'
NPROCS  = $(shell nproc)
endif
# MAKEFLAGS += -j$(NPROCS)
gnu = 0
ifeq '$(gnu)' '1'
CXXFLAGS += $(stdcxx_cxxflags)
LXXFLAGS += $(stdcxx_lxxflags)
endif

w = 1
ifeq '$(w)' '1'
CXXFLAGS += -Wextra -Werror -Wall
endif
debug = 1
ifeq '$(debug)' '1'
CXXFLAGS += -g
endif
asan = 0
ifeq '$(asan)' '1'
RUNFLAGS += ASAN_OPTIONS='detect_leaks=1'
LXXFLAGS += -lasan #-fsanitize=address
# LXXFLAGS += -fsanitize=thread
endif
test = 0
ifeq '$(test)' '1'
./$(attest) .
endif

%.o: %.cpp
	$(CC) $(CXXFLAGS) -c $< -o $@
all: $(DEPENDENCIES)
	@$(MAKE) $(NAME) $(TEST)
$(NAME): $(OBJS) $(CMD_CPARSER)
	$(CC) $(LXXFLAGS) $(CMD_CPARSER) $(OBJS) -o $(NAME)
$(TEST): $(OBJS) $(CMD_CTEST)
	$(CC) $(LXXFLAGS) $(CMD_CTEST) $(OBJS) -o $(TEST)
run: re
	$(RUNFLAGS) ./$(NAME) $(args)
clean:
	$(RM) $(OBJS) $(B_OBJ) $(CMDS)
fclean: clean
	$(RM) $(NAME) $(TEST) & wait
re: fclean
	$(MAKE) all
.PHONY: all clean fclean re run
