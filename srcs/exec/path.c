/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   path.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ebengtss <ebengtss@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/09/03 14:29:15 by ebengtss          #+#    #+#             */
/*   Updated: 2024/10/16 14:14:19 by ebengtss         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../incs/minishell.h"

static int	is_path(char *cmdve)
{
	size_t	i;

	i = 0;
	while (cmdve[i])
	{
		if (cmdve[i] == '/')
			return (1);
		i++;
	}
	return (0);
}

static int	cmds_path3(char **cmdve, char **env_path)
{
	char	*path;
	int		i;

	i = 0;
	while (env_path[i])
	{
		path = ft_strjoin_c(env_path[i], cmdve[0], '/', 0);
		if (!path)
			return (ft_puterror("error building cmd\n"), 1);
		if (access(path, F_OK) == 0)
		{
			free(cmdve[0]);
			cmdve[0] = ft_strdup(path);
			if (access(path, X_OK) == 0)
				return (free(path), 0);
		}
		free(path);
		i++;
	}
	return (0);
}

static int	cmds_path2(char ***cmdve, char **env_path, t_data *data)
{
	int		i;

	i = 0;
	while (i < data->cmdvesize)
	{
		if (cmdve[i] && cmdve[i][0] && cmdve[i][0][0])
			if (!is_builtin(cmdve[i][0]) && !is_path(cmdve[i][0]))
				if (access(cmdve[i][0], X_OK) != 0)
					if (cmds_path3(cmdve[i], env_path))
						return (1);
		i++;
	}
	return (0);
}

int	cmds_path(char ***cmdve, t_data *data)
{
	char	**paths;
	t_env	*env;

	env = data->envs->env;
	while (env)
	{
		if (ft_strncmp("PATH", env->key, 4) == 0)
		{
			paths = ft_split(env->val, ':');
			if (!paths)
				return (ft_puterror("error extracting paths\n"), 1);
			if (cmds_path2(cmdve, paths, data))
				return (ft_free_split(paths), 1);
			ft_free_split(paths);
		}
		env = env->next;
	}
	return (0);
}
