NAME = fractol

RANDOM_DIGIT := $(shell echo $$((RANDOM % 10)))

DEF_COLOR = \033[0;39m
CLR2 = \033[0;32m  # Orangeish color with a random last digit
CLR1 = \033[0;48m  # Complementary orangeish color with a random last digit


CC = cc
CFLAGS = #-Wall -Werror -Wextra
RM = rm -rf

# Directories
SRC_DIR =
OBJ_DIR = obj
INCLUDE = include

# Sources
SRC_FILES = fractol \
			fractol_hooks_aka_key_controls fractol_mandelbrot \
			fractol_utilities

SRC = $(addsuffix .c, $(SRC_FILES))
OBJ = $(addprefix $(OBJ_DIR)/, $(addsuffix .o, $(SRC_FILES)))

LIBFT = libft.a
MINILIBX = minilibx/libmlx_Linux.a
LFLAGS = -Lminilibx -lmlx -lXext -lX11 -lm #okay this cost me .... fml lol

# Rule to compile .c files into .o files
$(OBJ_DIR)/%.o: %.c
	$(CC) $(CFLAGS) -I$(INCLUDE) -c $< -o $@ 

# Rule to build the executable  and run
$(NAME): libft $(OBJ)
	$(CC) $(CFLAGS) -o $@ $(OBJ) $(LIBFT) $(LFLAGS)
	# @clear 
	@echo "$(CLR2)rdy$(DEF_COLOR)"


libft:
		@ make -C libft/

clean:
		@ $(RM) $(OBJ)
		@ $(RM) $(NAME)
		@echo "$(CLR1)               $(NAME) wiped! have a nice day ;-)$(DEF_COLOR)"
		@echo "$(CLR2)               please recompile to proceed.$(DEF_COLOR)"
		@sleep 1

fclean: clean
		@ $(RM) $(NAME)
		@ $(RM) libft.a
		@ make -C libft/ clean
		@clear
		@echo "$(CLR1)               all wiped boss! have a nice day ;-)$(DEF_COLOR)"
		@sleep 1
		@clear

re: fclean all $(NAME)
	@sleep 1

norm:
		@clear
		@norminette $(NAME).c $(NAME).h

run:
		make $(NAME)
		@clear
		@echo "$(CLR2)--------- clean program run ---------$(DEF_COLOR)"
		./$(NAME)
		@echo
		@echo
		@echo "$(CLR2)--------- clean program run ---------$(DEF_COLOR)"

valgrind:
		valgrind --leak-check=full ./$(NAME)


.PHONY: all libft clean fclean re norm $(NAME) run

