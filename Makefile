# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mtrullar <mtrullar@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/04 15:03:37 by ebengtss          #+#    #+#              #
#    Updated: 2024/10/17 14:53:56 by mtrullar         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

MAKEFLAGS 			+=	--no-print-directory

NAME				=	minishell

LIBFT				=	libft
LIBFT_A				=	libcustomft.a

CC					=	clang
CFLAGS				=	-Wall -Wextra -Werror -g -I

LIBFT_DIR			=	libft
SRCS_DIR			=	srcs/
BUILTINS_DIR		=	$(SRCS_DIR)builtins/
ENV_DIR				=	$(SRCS_DIR)env/
EXEC_DIR			=	$(SRCS_DIR)exec/
FREE_FUNC_DIR		=	$(SRCS_DIR)frees/
HISTORY_DIR			=	$(SRCS_DIR)history/
PARSING_DIR			=	$(SRCS_DIR)parsing/
OBJS_DIR			=	objs/
INCS_DIR			=	incs

SRCS_FILES			=	main.c				builtins.c			\
						ft_cd.c				var_list_func.c		\
						ft_echo.c			exec.c				\
						ft_env.c			path.c				\
						ft_exit.c			parsing.c			\
						ft_export.c			redirs.c			\
						ft_pwd.c			run.c				\
						ft_unset.c			free.c				\
						flat_string.c		history.c			\
						handle_variable.c	commands_struct.c	\
						here_docs.c			tokenization.c		\
						tokens_struct.c		free2.c				\
						env_init.c			env_list.c			\
						env_list2.c			cmdve.c				\
						check_error.c		env_init3.c			\
						ft_env2.c			env_init2.c			\
						tokenization_util.c utils.c				\
						hd_list.c			get_type.c			\
						split_redir.c		flat_string_bis.c	\
						ft_cd2.c			env_utils.c			\
						main2.c				flat_string_cond.c	\
						

OBJS				=	$(addprefix $(OBJS_DIR), $(SRCS_FILES:.c=.o))

DEF_COLOR			=	\033[0;39m
MAGENTA				=	\033[0;95m
GREEN				=	\033[0;92m
DEF_STYLE			=	\e[0m
BOLD_OPACITY		=	\e[1m\e[2m
RESET_LINE			=	\033[A\033[K

OBJSF				=	.objs_exists

all					:	$(NAME)

compile				=							\
    $(CC) $(CFLAGS) $(INCS_DIR) -c $< -o $@;	\
    echo "$(RESET_LINE)$(BOLD_OPACITY)[ MINISHELL ]$(DEF_STYLE)    compiling:    $(GREEN) $< $(DEF_COLOR)"

$(NAME)				:	$(LIBFT_A) $(OBJS)
	@echo "$(RESET_LINE)$(BOLD_OPACITY)[ MINISHELL ]$(DEF_STYLE)	compiling:	$(GREEN) ✔ $(DEF_COLOR)"
	@$(CC) -o $(NAME) $(CFLAGS) $(INCS_DIR) $(OBJS) $(LIBFT_A) -lreadline
	@echo "$(BOLD_OPACITY)[ MINISHELL ]$(DEF_STYLE)	make:		$(GREEN) ✔ $(DEF_COLOR)"

$(LIBFT_A)			:
	@make -C $(LIBFT_DIR)
	@mv $(LIBFT)/$(LIBFT_A) ./

$(OBJS_DIR)%.o		:	$(SRCS_DIR)%.c | $(OBJSF)
	@$(compile)

$(OBJS_DIR)%.o		:	$(BUILTINS_DIR)%.c | $(OBJSF)
	@$(compile)

$(OBJS_DIR)%.o		:	$(ENV_DIR)%.c | $(OBJSF)
	@$(compile)

$(OBJS_DIR)%.o		:	$(EXEC_DIR)%.c | $(OBJSF)
	@$(compile)

$(OBJS_DIR)%.o		:	$(FREE_FUNC_DIR)%.c | $(OBJSF)
	@$(compile)

$(OBJS_DIR)%.o		:	$(HISTORY_DIR)%.c | $(OBJSF)
	@$(compile)

$(OBJS_DIR)%.o		:	$(PARSING_DIR)%.c | $(OBJSF)
	@$(compile)

$(OBJSF)	:
	@echo "$(BOLD_OPACITY)[ MINISHELL ]$(DEF_STYLE)	nothing to do"
	@mkdir -p $(OBJS_DIR)

clean			:
	@rm -rf $(OBJS_DIR)
	@make clean -C $(LIBFT)
	@rm -f $(LIBFT_A)
	@echo "$(BOLD_OPACITY)[ MINISHELL ]$(DEF_STYLE)	clean:		$(GREEN) ✔ $(DEF_COLOR)"

fclean			:	clean
	@rm -f $(NAME)
	@echo "$(BOLD_OPACITY)[ MINISHELL ]$(DEF_STYLE)	fclean:		$(GREEN) ✔ $(DEF_COLOR)"

re				:	fclean all

.PHONY			:	all bonus clean fclean re 