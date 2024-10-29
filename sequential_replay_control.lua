obs = obslua

-- Идентификатор горячей клавиши
sequence_hotkey_id = obs.OBS_INVALID_HOTKEY_ID

-- Фаза выполнения
current_phase = "idle"  -- Начальное состояние

-- Функция, запускающая последовательность команд
function execute_replay_sequence()
    if current_phase == "idle" then  -- Проверка, не выполняется ли уже последовательность
        print("Запуск последовательности: Сохранить повторы...")
        current_phase = "save"  -- Устанавливаем текущую фазу
        save_replay()            -- Начинаем с сохранения повтора
    else
        print("Последовательность уже выполняется, игнорируем нажатие.")
    end
end

-- Функция для сохранения повтора
function save_replay()
    print("Сохранение повтора...")
    obs.obs_frontend_replay_buffer_save()
    obs.timer_add(check_if_saved, 100)  -- Запускаем проверку статуса сохранения
end

-- Проверка, завершилось ли сохранение
function check_if_saved()
    if obs.obs_frontend_replay_buffer_active() then
        print("Сохранение завершено, остановка повтора...")
        current_phase = "stop"  -- Переходим к остановке
        obs.timer_remove(check_if_saved)  -- Убираем таймер проверки
        stop_replay()                      -- Переходим к остановке повтора
    end
end

-- Функция для остановки повтора
function stop_replay()
    print("Остановка повтора...")
    obs.obs_frontend_replay_buffer_stop()  -- Останавливаем повтор
    obs.timer_add(check_if_stopped, 100)    -- Запускаем проверку статуса остановки
end

-- Проверка, завершилась ли остановка
function check_if_stopped()
    if not obs.obs_frontend_replay_buffer_active() then
        print("Повтор остановлен, запуск повтора...")
        current_phase = "start"  -- Переходим к запуску
        obs.timer_remove(check_if_stopped)  -- Убираем таймер проверки
        start_replay()                       -- Запускаем повтор
    end
end

-- Функция для запуска повтора
function start_replay()
    print("Запуск повтора...")
    obs.obs_frontend_replay_buffer_start()  -- Запускаем повтор
    current_phase = "idle"                  -- Возвращаем состояние к "idle" после запуска
    print("Повтор успешно запущен.")
end

-- Автоматический запуск повтора при старте OBS
function script_load(settings)
    -- Регистрируем горячую клавишу
    sequence_hotkey_id = obs.obs_hotkey_register_frontend("replay_sequence", "Сохранить-Остановить-Запустить повтор", execute_replay_sequence)

    -- Загружаем горячую клавишу из настроек
    local hotkey_array = obs.obs_data_get_array(settings, "replay_sequence")
    obs.obs_hotkey_load(sequence_hotkey_id, hotkey_array)
    obs.obs_data_array_release(hotkey_array)

    -- Автоматический запуск повтора при старте OBS
    if not obs.obs_frontend_replay_buffer_active() then
        obs.obs_frontend_replay_buffer_start()
    end
end

-- Сохранение настроек горячей клавиши
function script_save(settings)
    local hotkey_array = obs.obs_hotkey_save(sequence_hotkey_id)
    obs.obs_data_set_array(settings, "replay_sequence", hotkey_array)
    obs.obs_data_array_release(hotkey_array)
end

-- Описание скрипта
function script_description()
    return "Скрипт автоматически запускает повтор при старте OBS и выполняет последовательные команды Сохранить-Остановить-Запустить повтор по одной горячей клавише."
end
