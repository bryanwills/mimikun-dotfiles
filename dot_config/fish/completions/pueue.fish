# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_pueue_global_optspecs
	string join \n v/verbose color= c/config= p/profile= h/help V/version
end

function __fish_pueue_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_pueue_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_pueue_using_subcommand
	set -l cmd (__fish_pueue_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c pueue -n "__fish_pueue_needs_command" -l color -d 'Colorize the output; auto enables color output when connected to a tty' -r -f -a "auto\t''
never\t''
always\t''"
complete -c pueue -n "__fish_pueue_needs_command" -s c -l config -d 'If provided, Pueue only uses this config file. This path can also be set via the "PUEUE_CONFIG_PATH" environment variable. The commandline option overwrites the environment variable!' -r -F
complete -c pueue -n "__fish_pueue_needs_command" -s p -l profile -d 'The name of the profile that should be loaded from your config file' -r
complete -c pueue -n "__fish_pueue_needs_command" -s v -l verbose -d 'Verbose mode (-v, -vv, -vvv)'
complete -c pueue -n "__fish_pueue_needs_command" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_needs_command" -s V -l version -d 'Print version'
complete -c pueue -n "__fish_pueue_needs_command" -f -a "add" -d 'Enqueue a task for execution. There\'re many different options when scheduling a task. Check the individual option help texts for more information.  Furthermore, please remember that scheduled commands are executed via your system shell. This means that the command needs proper shell escaping. The safest way to preserve shell escaping is to surround your command with quotes, for example: pueue add \'ls $HOME && echo "Some string"\''
complete -c pueue -n "__fish_pueue_needs_command" -f -a "remove" -d 'Remove tasks from the list. Running or paused tasks need to be killed first'
complete -c pueue -n "__fish_pueue_needs_command" -f -a "switch" -d 'Switches the queue position of two commands. Only works on queued and stashed commands'
complete -c pueue -n "__fish_pueue_needs_command" -f -a "stash" -d 'Stashed tasks won\'t be automatically started. You have to enqueue them or start them by hand'
complete -c pueue -n "__fish_pueue_needs_command" -f -a "enqueue" -d 'Enqueue stashed tasks. They\'ll be handled normally afterwards'
complete -c pueue -n "__fish_pueue_needs_command" -f -a "start" -d 'Resume operation of specific tasks or groups of tasks. By default, this resumes the default group and all its tasks. Can also be used force-start specific tasks.'
complete -c pueue -n "__fish_pueue_needs_command" -f -a "restart" -d 'Restart failed or successful task(s). By default, identical tasks will be created and enqueued, but it\'s possible to restart in-place. You can also edit a few properties, such as the path and the command, before restarting.'
complete -c pueue -n "__fish_pueue_needs_command" -f -a "pause" -d 'Either pause running tasks or specific groups of tasks. By default, pauses the default group and all its tasks. A paused queue (group) won\'t start any new tasks.'
complete -c pueue -n "__fish_pueue_needs_command" -f -a "kill" -d 'Kill specific running tasks or whole task groups.. Kills all tasks of the default group when no ids or a specific group are provided.'
complete -c pueue -n "__fish_pueue_needs_command" -f -a "send" -d 'Send something to a task. Useful for sending confirmations such as \'y\\n\''
complete -c pueue -n "__fish_pueue_needs_command" -f -a "edit" -d 'Edit the command, path, label, or priority of a stashed or queued task. By default only the command is edited. Multiple properties can be added in one go.'
complete -c pueue -n "__fish_pueue_needs_command" -f -a "group" -d 'Use this to add or remove groups. By default, this will simply display all known groups.'
complete -c pueue -n "__fish_pueue_needs_command" -f -a "status" -d 'Display the current status of all tasks'
complete -c pueue -n "__fish_pueue_needs_command" -f -a "format-status" -d 'Accept a list or map of JSON pueue tasks via stdin and display it just like "pueue status". A simple example might look like this: pueue status --json | jq -c \'.tasks\' | pueue format-status'
complete -c pueue -n "__fish_pueue_needs_command" -f -a "log" -d 'Display the log output of finished tasks. Only the last few lines will be shown by default. If you want to follow the output of a task, please use the "follow" subcommand.'
complete -c pueue -n "__fish_pueue_needs_command" -f -a "follow" -d 'Follow the output of a currently running task. This command works like "tail -f"'
complete -c pueue -n "__fish_pueue_needs_command" -f -a "wait" -d 'Wait until tasks are finished. By default, this will wait for all tasks in the default group to finish. Note: This will also wait for all tasks that aren\'t somehow \'Done\'. Includes: [Paused, Stashed, Locked, Queued, ...]'
complete -c pueue -n "__fish_pueue_needs_command" -f -a "clean" -d 'Remove all finished tasks from the list'
complete -c pueue -n "__fish_pueue_needs_command" -f -a "reset" -d 'Kill all tasks, clean up afterwards and reset EVERYTHING!'
complete -c pueue -n "__fish_pueue_needs_command" -f -a "shutdown" -d 'Remotely shut down the daemon. Should only be used if the daemon isn\'t started by a service manager'
complete -c pueue -n "__fish_pueue_needs_command" -f -a "parallel" -d 'Set the amount of allowed parallel tasks By default, adjusts the amount of the default group. No tasks will be stopped, if this is lowered. This limit is only considered when tasks are scheduled.'
complete -c pueue -n "__fish_pueue_needs_command" -f -a "completions" -d 'Generates shell completion files. This can be ignored during normal operations'
complete -c pueue -n "__fish_pueue_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c pueue -n "__fish_pueue_using_subcommand add" -s w -l working-directory -d 'Specify current working directory' -r -f -a "(__fish_complete_directories)"
complete -c pueue -n "__fish_pueue_using_subcommand add" -s d -l delay -d 'Prevents the task from being enqueued until \'delay\' elapses. See "enqueue" for accepted formats' -r
complete -c pueue -n "__fish_pueue_using_subcommand add" -s g -l group -d 'Assign the task to a group. Groups kind of act as separate queues. I.e. all groups run in parallel and you can specify the amount of parallel tasks for each group. If no group is specified, the default group will be used' -r
complete -c pueue -n "__fish_pueue_using_subcommand add" -s a -l after -d 'Start the task once all specified tasks have successfully finished. As soon as one of the dependencies fails, this task will fail as well' -r
complete -c pueue -n "__fish_pueue_using_subcommand add" -s o -l priority -d 'Start this task with a higher priority. The higher the number, the faster it will be processed' -r
complete -c pueue -n "__fish_pueue_using_subcommand add" -s l -l label -d 'Add some information for yourself. This string will be shown in the "status" table. There\'s no additional logic connected to it' -r
complete -c pueue -n "__fish_pueue_using_subcommand add" -s e -l escape -d 'Escape any special shell characters (" ", "&", "!", etc.). Beware: This implicitly disables nearly all shell specific syntax ("&&", "&>")'
complete -c pueue -n "__fish_pueue_using_subcommand add" -s i -l immediate -d 'Immediately start the task'
complete -c pueue -n "__fish_pueue_using_subcommand add" -s s -l stashed -d 'Create the task in Stashed state. Useful to avoid immediate execution if the queue is empty'
complete -c pueue -n "__fish_pueue_using_subcommand add" -s p -l print-task-id -d 'Only return the task id instead of a text. This is useful when working with dependencies'
complete -c pueue -n "__fish_pueue_using_subcommand add" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand remove" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand switch" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand stash" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand enqueue" -s d -l delay -d 'Delay enqueuing these tasks until \'delay\' elapses. See DELAY FORMAT below' -r
complete -c pueue -n "__fish_pueue_using_subcommand enqueue" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand start" -s g -l group -d 'Resume a specific group and all paused tasks in it. The group will be set to running and its paused tasks will be resumed' -r
complete -c pueue -n "__fish_pueue_using_subcommand start" -s a -l all -d 'Resume all groups! All groups will be set to running and paused tasks will be resumed'
complete -c pueue -n "__fish_pueue_using_subcommand start" -s c -l children -d 'Deprecated: this switch no longer has any effect'
complete -c pueue -n "__fish_pueue_using_subcommand start" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand restart" -s g -l failed-in-group -d 'Like `--all-failed`, but only restart tasks failed tasks of a specific group. The group will be set to running and its paused tasks will be resumed' -r
complete -c pueue -n "__fish_pueue_using_subcommand restart" -s a -l all-failed -d 'Restart all failed tasks across all groups. Nice to use in combination with `-i/--in-place`'
complete -c pueue -n "__fish_pueue_using_subcommand restart" -s k -l start-immediately -d 'Immediately start the tasks, no matter how many open slots there are. This will ignore any dependencies tasks may have'
complete -c pueue -n "__fish_pueue_using_subcommand restart" -s s -l stashed -d 'Set the restarted task to a "Stashed" state. Useful to avoid immediate execution'
complete -c pueue -n "__fish_pueue_using_subcommand restart" -s i -l in-place -d 'Restart the task by reusing the already existing tasks. This will overwrite any previous logs of the restarted tasks'
complete -c pueue -n "__fish_pueue_using_subcommand restart" -l not-in-place -d 'Restart the task by creating a new identical tasks. Only applies, if you have the restart_in_place configuration set to true'
complete -c pueue -n "__fish_pueue_using_subcommand restart" -s e -l edit -d 'Edit the tasks\' commands before restarting'
complete -c pueue -n "__fish_pueue_using_subcommand restart" -s p -l edit-path -d 'Edit the tasks\' paths before restarting'
complete -c pueue -n "__fish_pueue_using_subcommand restart" -s l -l edit-label -d 'Edit the tasks\' labels before restarting'
complete -c pueue -n "__fish_pueue_using_subcommand restart" -s o -l edit-priority -d 'Edit the tasks\' priorities before restarting'
complete -c pueue -n "__fish_pueue_using_subcommand restart" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand pause" -s g -l group -d 'Pause a specific group' -r
complete -c pueue -n "__fish_pueue_using_subcommand pause" -s a -l all -d 'Pause all groups!'
complete -c pueue -n "__fish_pueue_using_subcommand pause" -s w -l wait -d 'Only pause the specified group and let already running tasks finish by themselves'
complete -c pueue -n "__fish_pueue_using_subcommand pause" -s c -l children -d 'Deprecated: this switch no longer has any effect'
complete -c pueue -n "__fish_pueue_using_subcommand pause" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand kill" -s g -l group -d 'Kill all running tasks in a group. This also pauses the group' -r
complete -c pueue -n "__fish_pueue_using_subcommand kill" -s s -l signal -d 'Send a UNIX signal instead of simply killing the process. DISCLAIMER: This bypasses Pueue\'s process handling logic! You might enter weird invalid states, use at your own descretion' -r
complete -c pueue -n "__fish_pueue_using_subcommand kill" -s a -l all -d 'Kill all running tasks across ALL groups. This also pauses all groups'
complete -c pueue -n "__fish_pueue_using_subcommand kill" -s c -l children -d 'Deprecated: this switch no longer has any effect'
complete -c pueue -n "__fish_pueue_using_subcommand kill" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand send" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand edit" -s c -l command -d 'Edit the task\'s command'
complete -c pueue -n "__fish_pueue_using_subcommand edit" -s p -l path -d 'Edit the task\'s path'
complete -c pueue -n "__fish_pueue_using_subcommand edit" -s l -l label -d 'Edit the task\'s label'
complete -c pueue -n "__fish_pueue_using_subcommand edit" -s o -l priority -d 'Edit the task\'s priority'
complete -c pueue -n "__fish_pueue_using_subcommand edit" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand group; and not __fish_seen_subcommand_from add remove help" -s j -l json -d 'Print the list of groups as json'
complete -c pueue -n "__fish_pueue_using_subcommand group; and not __fish_seen_subcommand_from add remove help" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand group; and not __fish_seen_subcommand_from add remove help" -f -a "add" -d 'Add a group by name'
complete -c pueue -n "__fish_pueue_using_subcommand group; and not __fish_seen_subcommand_from add remove help" -f -a "remove" -d 'Remove a group by name. This will move all tasks in this group to the default group!'
complete -c pueue -n "__fish_pueue_using_subcommand group; and not __fish_seen_subcommand_from add remove help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c pueue -n "__fish_pueue_using_subcommand group; and __fish_seen_subcommand_from add" -s p -l parallel -d 'Set the amount of parallel tasks this group can have. Setting this to 0 means an unlimited amount of parallel tasks' -r
complete -c pueue -n "__fish_pueue_using_subcommand group; and __fish_seen_subcommand_from add" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand group; and __fish_seen_subcommand_from remove" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand group; and __fish_seen_subcommand_from help" -f -a "add" -d 'Add a group by name'
complete -c pueue -n "__fish_pueue_using_subcommand group; and __fish_seen_subcommand_from help" -f -a "remove" -d 'Remove a group by name. This will move all tasks in this group to the default group!'
complete -c pueue -n "__fish_pueue_using_subcommand group; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c pueue -n "__fish_pueue_using_subcommand status" -s g -l group -d 'Only show tasks of a specific group' -r
complete -c pueue -n "__fish_pueue_using_subcommand status" -s j -l json -d 'Print the current state as json to stdout. This does not include the output of tasks. Use `log -j` if you want everything'
complete -c pueue -n "__fish_pueue_using_subcommand status" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c pueue -n "__fish_pueue_using_subcommand format-status" -s g -l group -d 'Only show tasks of a specific group' -r
complete -c pueue -n "__fish_pueue_using_subcommand format-status" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand log" -s l -l lines -d 'Only print the last X lines of each task\'s output. This is done by default if you\'re looking at multiple tasks' -r
complete -c pueue -n "__fish_pueue_using_subcommand log" -s j -l json -d 'Print the resulting tasks and output as json. By default only the last lines will be returned unless --full is provided. Take care, as the json cannot be streamed! If your logs are really huge, using --full can use all of your machine\'s RAM'
complete -c pueue -n "__fish_pueue_using_subcommand log" -s f -l full -d 'Show the whole output'
complete -c pueue -n "__fish_pueue_using_subcommand log" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand follow" -s l -l lines -d 'Only print the last X lines of the output before following' -r
complete -c pueue -n "__fish_pueue_using_subcommand follow" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand wait" -s g -l group -d 'Wait for all tasks in a specific group' -r
complete -c pueue -n "__fish_pueue_using_subcommand wait" -s s -l status -d 'Wait for tasks to reach a specific task status' -r
complete -c pueue -n "__fish_pueue_using_subcommand wait" -s a -l all -d 'Wait for all tasks across all groups and the default group'
complete -c pueue -n "__fish_pueue_using_subcommand wait" -s q -l quiet -d 'Don\'t show any log output while waiting'
complete -c pueue -n "__fish_pueue_using_subcommand wait" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand clean" -s g -l group -d 'Only clean tasks of a specific group' -r
complete -c pueue -n "__fish_pueue_using_subcommand clean" -s s -l successful-only -d 'Only clean tasks that finished successfully'
complete -c pueue -n "__fish_pueue_using_subcommand clean" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand reset" -s c -l children -d 'Deprecated: this switch no longer has any effect'
complete -c pueue -n "__fish_pueue_using_subcommand reset" -s f -l force -d 'Don\'t ask for any confirmation'
complete -c pueue -n "__fish_pueue_using_subcommand reset" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand shutdown" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand parallel" -s g -l group -d 'Set the amount for a specific group' -r
complete -c pueue -n "__fish_pueue_using_subcommand parallel" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand completions" -s h -l help -d 'Print help'
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "add" -d 'Enqueue a task for execution. There\'re many different options when scheduling a task. Check the individual option help texts for more information.  Furthermore, please remember that scheduled commands are executed via your system shell. This means that the command needs proper shell escaping. The safest way to preserve shell escaping is to surround your command with quotes, for example: pueue add \'ls $HOME && echo "Some string"\''
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "remove" -d 'Remove tasks from the list. Running or paused tasks need to be killed first'
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "switch" -d 'Switches the queue position of two commands. Only works on queued and stashed commands'
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "stash" -d 'Stashed tasks won\'t be automatically started. You have to enqueue them or start them by hand'
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "enqueue" -d 'Enqueue stashed tasks. They\'ll be handled normally afterwards'
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "start" -d 'Resume operation of specific tasks or groups of tasks. By default, this resumes the default group and all its tasks. Can also be used force-start specific tasks.'
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "restart" -d 'Restart failed or successful task(s). By default, identical tasks will be created and enqueued, but it\'s possible to restart in-place. You can also edit a few properties, such as the path and the command, before restarting.'
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "pause" -d 'Either pause running tasks or specific groups of tasks. By default, pauses the default group and all its tasks. A paused queue (group) won\'t start any new tasks.'
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "kill" -d 'Kill specific running tasks or whole task groups.. Kills all tasks of the default group when no ids or a specific group are provided.'
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "send" -d 'Send something to a task. Useful for sending confirmations such as \'y\\n\''
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "edit" -d 'Edit the command, path, label, or priority of a stashed or queued task. By default only the command is edited. Multiple properties can be added in one go.'
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "group" -d 'Use this to add or remove groups. By default, this will simply display all known groups.'
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "status" -d 'Display the current status of all tasks'
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "format-status" -d 'Accept a list or map of JSON pueue tasks via stdin and display it just like "pueue status". A simple example might look like this: pueue status --json | jq -c \'.tasks\' | pueue format-status'
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "log" -d 'Display the log output of finished tasks. Only the last few lines will be shown by default. If you want to follow the output of a task, please use the "follow" subcommand.'
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "follow" -d 'Follow the output of a currently running task. This command works like "tail -f"'
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "wait" -d 'Wait until tasks are finished. By default, this will wait for all tasks in the default group to finish. Note: This will also wait for all tasks that aren\'t somehow \'Done\'. Includes: [Paused, Stashed, Locked, Queued, ...]'
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "clean" -d 'Remove all finished tasks from the list'
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "reset" -d 'Kill all tasks, clean up afterwards and reset EVERYTHING!'
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "shutdown" -d 'Remotely shut down the daemon. Should only be used if the daemon isn\'t started by a service manager'
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "parallel" -d 'Set the amount of allowed parallel tasks By default, adjusts the amount of the default group. No tasks will be stopped, if this is lowered. This limit is only considered when tasks are scheduled.'
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "completions" -d 'Generates shell completion files. This can be ignored during normal operations'
complete -c pueue -n "__fish_pueue_using_subcommand help; and not __fish_seen_subcommand_from add remove switch stash enqueue start restart pause kill send edit group status format-status log follow wait clean reset shutdown parallel completions help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c pueue -n "__fish_pueue_using_subcommand help; and __fish_seen_subcommand_from group" -f -a "add" -d 'Add a group by name'
complete -c pueue -n "__fish_pueue_using_subcommand help; and __fish_seen_subcommand_from group" -f -a "remove" -d 'Remove a group by name. This will move all tasks in this group to the default group!'
