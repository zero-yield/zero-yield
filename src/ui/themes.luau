return function(env)
	function updateColors(color, ctype)
		if ctype == shade1 then
			for i, v in pairs(shade1) do
				v.BackgroundColor3 = color
			end
			currentShade1 = color
		elseif ctype == shade2 then
			for i, v in pairs(shade2) do
				v.BackgroundColor3 = color
			end
			currentShade2 = color
		elseif ctype == shade3 then
			for i, v in pairs(shade3) do
				v.BackgroundColor3 = color
			end
			currentShade3 = color
		elseif ctype == text1 then
			for i, v in pairs(text1) do
				v.TextColor3 = color
				if v:IsA("TextBox") then
					v.PlaceholderColor3 = color
				end
			end
			currentText1 = color
		elseif ctype == text2 then
			for i, v in pairs(text2) do
				v.TextColor3 = color
			end
			currentText2 = color
		elseif ctype == scroll then
			for i, v in pairs(scroll) do
				v.ScrollBarImageColor3 = color
			end
			currentScroll = color
		end
	end

	local colorpickerOpen = false
	ColorsButton.MouseButton1Click:Connect(function()
		cache_currentShade1 = currentShade1
		cache_currentShade2 = currentShade2
		cache_currentShade3 = currentShade3
		cache_currentText1 = currentText1
		cache_currentText2 = currentText2
		cache_currentScroll = currentScroll
		if not colorpickerOpen then
			colorpickerOpen = true
			picker = game:GetObjects("rbxassetid://4908465318")[1]
			picker.Name = randomString()
			picker.Parent = ScaledHolder

			local ColorPicker
			do
				ColorPicker = {}

				ColorPicker.new = function()
					local newMt = setmetatable({}, {})

					local pickerGui = picker.ColorPicker
					local pickerTopBar = pickerGui.TopBar
					local pickerExit = pickerTopBar.Exit
					local pickerFrame = pickerGui.Content
					local colorSpace = pickerFrame.ColorSpaceFrame.ColorSpace
					local colorStrip = pickerFrame.ColorStrip
					local previewFrame = pickerFrame.Preview
					local basicColorsFrame = pickerFrame.BasicColors
					local customColorsFrame = pickerFrame.CustomColors
					local defaultButton = pickerFrame.Default
					local cancelButton = pickerFrame.Cancel
					local shade1Button = pickerFrame.Shade1
					local shade2Button = pickerFrame.Shade2
					local shade3Button = pickerFrame.Shade3
					local text1Button = pickerFrame.Text1
					local text2Button = pickerFrame.Text2
					local scrollButton = pickerFrame.Scroll

					local colorScope = colorSpace.Scope
					local colorArrow = pickerFrame.ArrowFrame.Arrow

					local hueInput = pickerFrame.Hue.Input
					local satInput = pickerFrame.Sat.Input
					local valInput = pickerFrame.Val.Input

					local redInput = pickerFrame.Red.Input
					local greenInput = pickerFrame.Green.Input
					local blueInput = pickerFrame.Blue.Input

					local mouse = ZYMouse

					local hue, sat, val = 0, 0, 1
					local red, green, blue = 1, 1, 1
					local chosenColor = Color3.new(0, 0, 0)

					local basicColors = {
						Color3.new(0, 0, 0),
						Color3.new(0.66666668653488, 0, 0),
						Color3.new(0, 0.33333334326744, 0),
						Color3.new(0.66666668653488, 0.33333334326744, 0),
						Color3.new(0, 0.66666668653488, 0),
						Color3.new(0.66666668653488, 0.66666668653488, 0),
						Color3.new(0, 1, 0),
						Color3.new(0.66666668653488, 1, 0),
						Color3.new(0, 0, 0.49803924560547),
						Color3.new(0.66666668653488, 0, 0.49803924560547),
						Color3.new(0, 0.33333334326744, 0.49803924560547),
						Color3.new(0.66666668653488, 0.33333334326744, 0.49803924560547),
						Color3.new(0, 0.66666668653488, 0.49803924560547),
						Color3.new(0.66666668653488, 0.66666668653488, 0.49803924560547),
						Color3.new(0, 1, 0.49803924560547),
						Color3.new(0.66666668653488, 1, 0.49803924560547),
						Color3.new(0, 0, 1),
						Color3.new(0.66666668653488, 0, 1),
						Color3.new(0, 0.33333334326744, 1),
						Color3.new(0.66666668653488, 0.33333334326744, 1),
						Color3.new(0, 0.66666668653488, 1),
						Color3.new(0.66666668653488, 0.66666668653488, 1),
						Color3.new(0, 1, 1),
						Color3.new(0.66666668653488, 1, 1),
						Color3.new(0.33333334326744, 0, 0),
						Color3.new(1, 0, 0),
						Color3.new(0.33333334326744, 0.33333334326744, 0),
						Color3.new(1, 0.33333334326744, 0),
						Color3.new(0.33333334326744, 0.66666668653488, 0),
						Color3.new(1, 0.66666668653488, 0),
						Color3.new(0.33333334326744, 1, 0),
						Color3.new(1, 1, 0),
						Color3.new(0.33333334326744, 0, 0.49803924560547),
						Color3.new(1, 0, 0.49803924560547),
						Color3.new(0.33333334326744, 0.33333334326744, 0.49803924560547),
						Color3.new(1, 0.33333334326744, 0.49803924560547),
						Color3.new(0.33333334326744, 0.66666668653488, 0.49803924560547),
						Color3.new(1, 0.66666668653488, 0.49803924560547),
						Color3.new(0.33333334326744, 1, 0.49803924560547),
						Color3.new(1, 1, 0.49803924560547),
						Color3.new(0.33333334326744, 0, 1),
						Color3.new(1, 0, 1),
						Color3.new(0.33333334326744, 0.33333334326744, 1),
						Color3.new(1, 0.33333334326744, 1),
						Color3.new(0.33333334326744, 0.66666668653488, 1),
						Color3.new(1, 0.66666668653488, 1),
						Color3.new(0.33333334326744, 1, 1),
						Color3.new(1, 1, 1),
					}
					local customColors = {}

					dragGUI(picker)

					local function updateColor(noupdate)
						local relativeX, relativeY, relativeStripY = 219 - hue * 219, 199 - sat * 199, 199 - val * 199
						local hsvColor = Color3.fromHSV(hue, sat, val)

						if noupdate == 2 or not noupdate then
							hueInput.Text = tostring(math.ceil(359 * hue))
							satInput.Text = tostring(math.ceil(255 * sat))
							valInput.Text = tostring(math.floor(255 * val))
						end
						if noupdate == 1 or not noupdate then
							redInput.Text = tostring(math.floor(255 * red))
							greenInput.Text = tostring(math.floor(255 * green))
							blueInput.Text = tostring(math.floor(255 * blue))
						end

						chosenColor = Color3.new(red, green, blue)

						colorScope.Position = UDim2.new(0, relativeX - 9, 0, relativeY - 9)
						colorStrip.ImageColor3 = Color3.fromHSV(hue, sat, 1)
						colorArrow.Position = UDim2.new(0, -2, 0, relativeStripY - 4)
						previewFrame.BackgroundColor3 = chosenColor

						newMt.Color = chosenColor
						if newMt.Changed then
							newMt:Changed(chosenColor)
						end
					end

					local function colorSpaceInput()
						local relativeX = mouse.X - colorSpace.AbsolutePosition.X
						local relativeY = mouse.Y - colorSpace.AbsolutePosition.Y

						if relativeX < 0 then
							relativeX = 0
						elseif relativeX > 219 then
							relativeX = 219
						end
						if relativeY < 0 then
							relativeY = 0
						elseif relativeY > 199 then
							relativeY = 199
						end

						hue = (219 - relativeX) / 219
						sat = (199 - relativeY) / 199

						local hsvColor = Color3.fromHSV(hue, sat, val)
						red, green, blue = hsvColor.r, hsvColor.g, hsvColor.b

						updateColor()
					end

					local function colorStripInput()
						local relativeY = mouse.Y - colorStrip.AbsolutePosition.Y

						if relativeY < 0 then
							relativeY = 0
						elseif relativeY > 199 then
							relativeY = 199
						end

						val = (199 - relativeY) / 199

						local hsvColor = Color3.fromHSV(hue, sat, val)
						red, green, blue = hsvColor.r, hsvColor.g, hsvColor.b

						updateColor()
					end

					local function hookButtons(frame, func)
						frame.ArrowFrame.Up.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseMovement then
								frame.ArrowFrame.Up.BackgroundTransparency = 0.5
							elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
								local releaseEvent, runEvent

								local startTime = tick()
								local pressing = true
								local startNum = tonumber(frame.Text)

								if not startNum then
									return
								end

								releaseEvent = UserInputService.InputEnded:Connect(function(input)
									if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
										return
									end
									releaseEvent:Disconnect()
									pressing = false
								end)

								startNum = startNum + 1
								func(startNum)
								while pressing do
									if tick() - startTime > 0.3 then
										startNum = startNum + 1
										func(startNum)
									end
									wait(0.1)
								end
							end
						end)

						frame.ArrowFrame.Up.InputEnded:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseMovement then
								frame.ArrowFrame.Up.BackgroundTransparency = 1
							end
						end)

						frame.ArrowFrame.Down.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseMovement then
								frame.ArrowFrame.Down.BackgroundTransparency = 0.5
							elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
								local releaseEvent, runEvent

								local startTime = tick()
								local pressing = true
								local startNum = tonumber(frame.Text)

								if not startNum then
									return
								end

								releaseEvent = UserInputService.InputEnded:Connect(function(input)
									if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
										return
									end
									releaseEvent:Disconnect()
									pressing = false
								end)

								startNum = startNum - 1
								func(startNum)
								while pressing do
									if tick() - startTime > 0.3 then
										startNum = startNum - 1
										func(startNum)
									end
									wait(0.1)
								end
							end
						end)

						frame.ArrowFrame.Down.InputEnded:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseMovement then
								frame.ArrowFrame.Down.BackgroundTransparency = 1
							end
						end)
					end

					colorSpace.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							local releaseEvent, mouseEvent

							releaseEvent = UserInputService.InputEnded:Connect(function(input)
								if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
									return
								end
								releaseEvent:Disconnect()
								mouseEvent:Disconnect()
							end)

							mouseEvent = UserInputService.InputChanged:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseMovement then
									colorSpaceInput()
								end
							end)

							colorSpaceInput()
						end
					end)

					colorStrip.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							local releaseEvent, mouseEvent

							releaseEvent = UserInputService.InputEnded:Connect(function(input)
								if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
									return
								end
								releaseEvent:Disconnect()
								mouseEvent:Disconnect()
							end)

							mouseEvent = UserInputService.InputChanged:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseMovement then
									colorStripInput()
								end
							end)

							colorStripInput()
						end
					end)

					local function updateHue(str)
						local num = tonumber(str)
						if num then
							hue = math.clamp(math.floor(num), 0, 359) / 359
							local hsvColor = Color3.fromHSV(hue, sat, val)
							red, green, blue = hsvColor.r, hsvColor.g, hsvColor.b
							hueInput.Text = tostring(hue * 359)
							updateColor(1)
						end
					end
					hueInput.FocusLost:Connect(function()
						updateHue(hueInput.Text)
					end)
					hookButtons(hueInput, updateHue)

					local function updateSat(str)
						local num = tonumber(str)
						if num then
							sat = math.clamp(math.floor(num), 0, 255) / 255
							local hsvColor = Color3.fromHSV(hue, sat, val)
							red, green, blue = hsvColor.r, hsvColor.g, hsvColor.b
							satInput.Text = tostring(sat * 255)
							updateColor(1)
						end
					end
					satInput.FocusLost:Connect(function()
						updateSat(satInput.Text)
					end)
					hookButtons(satInput, updateSat)

					local function updateVal(str)
						local num = tonumber(str)
						if num then
							val = math.clamp(math.floor(num), 0, 255) / 255
							local hsvColor = Color3.fromHSV(hue, sat, val)
							red, green, blue = hsvColor.r, hsvColor.g, hsvColor.b
							valInput.Text = tostring(val * 255)
							updateColor(1)
						end
					end
					valInput.FocusLost:Connect(function()
						updateVal(valInput.Text)
					end)
					hookButtons(valInput, updateVal)

					local function updateRed(str)
						local num = tonumber(str)
						if num then
							red = math.clamp(math.floor(num), 0, 255) / 255
							local newColor = Color3.new(red, green, blue)
							hue, sat, val = Color3.toHSV(newColor)
							redInput.Text = tostring(red * 255)
							updateColor(2)
						end
					end
					redInput.FocusLost:Connect(function()
						updateRed(redInput.Text)
					end)
					hookButtons(redInput, updateRed)

					local function updateGreen(str)
						local num = tonumber(str)
						if num then
							green = math.clamp(math.floor(num), 0, 255) / 255
							local newColor = Color3.new(red, green, blue)
							hue, sat, val = Color3.toHSV(newColor)
							greenInput.Text = tostring(green * 255)
							updateColor(2)
						end
					end
					greenInput.FocusLost:Connect(function()
						updateGreen(greenInput.Text)
					end)
					hookButtons(greenInput, updateGreen)

					local function updateBlue(str)
						local num = tonumber(str)
						if num then
							blue = math.clamp(math.floor(num), 0, 255) / 255
							local newColor = Color3.new(red, green, blue)
							hue, sat, val = Color3.toHSV(newColor)
							blueInput.Text = tostring(blue * 255)
							updateColor(2)
						end
					end
					blueInput.FocusLost:Connect(function()
						updateBlue(blueInput.Text)
					end)
					hookButtons(blueInput, updateBlue)

					local colorChoice = Instance.new("TextButton")
					colorChoice.Name = "Choice"
					colorChoice.Size = UDim2.new(0, 25, 0, 18)
					colorChoice.BorderColor3 = Color3.new(96 / 255, 96 / 255, 96 / 255)
					colorChoice.Text = ""
					colorChoice.AutoButtonColor = false
					colorChoice.ZIndex = 10

					local row = 0
					local column = 0
					for i, v in pairs(basicColors) do
						local newColor = colorChoice:Clone()
						newColor.BackgroundColor3 = v
						newColor.Position = UDim2.new(0, 1 + 30 * column, 0, 21 + 23 * row)

						newColor.MouseButton1Click:Connect(function()
							red, green, blue = v.r, v.g, v.b
							local newColor = Color3.new(red, green, blue)
							hue, sat, val = Color3.toHSV(newColor)
							updateColor()
						end)

						newColor.Parent = basicColorsFrame
						column = column + 1
						if column == 6 then
							row = row + 1
							column = 0
						end
					end

					row = 0
					column = 0
					for i = 1, 12 do
						local color = customColors[i] or Color3.new(0, 0, 0)
						local newColor = colorChoice:Clone()
						newColor.BackgroundColor3 = color
						newColor.Position = UDim2.new(0, 1 + 30 * column, 0, 20 + 23 * row)

						newColor.MouseButton1Click:Connect(function()
							local curColor = customColors[i] or Color3.new(0, 0, 0)
							red, green, blue = curColor.r, curColor.g, curColor.b
							hue, sat, val = Color3.toHSV(curColor)
							updateColor()
						end)

						newColor.MouseButton2Click:Connect(function()
							customColors[i] = chosenColor
							newColor.BackgroundColor3 = chosenColor
						end)

						newColor.Parent = customColorsFrame
						column = column + 1
						if column == 6 then
							row = row + 1
							column = 0
						end
					end

					shade1Button.MouseButton1Click:Connect(function()
						if newMt.Confirm then
							newMt:Confirm(chosenColor, shade1)
						end
					end)
					shade1Button.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							shade1Button.BackgroundTransparency = 0.4
						end
					end)
					shade1Button.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							shade1Button.BackgroundTransparency = 0
						end
					end)

					shade2Button.MouseButton1Click:Connect(function()
						if newMt.Confirm then
							newMt:Confirm(chosenColor, shade2)
						end
					end)
					shade2Button.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							shade2Button.BackgroundTransparency = 0.4
						end
					end)
					shade2Button.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							shade2Button.BackgroundTransparency = 0
						end
					end)

					shade3Button.MouseButton1Click:Connect(function()
						if newMt.Confirm then
							newMt:Confirm(chosenColor, shade3)
						end
					end)
					shade3Button.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							shade3Button.BackgroundTransparency = 0.4
						end
					end)
					shade3Button.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							shade3Button.BackgroundTransparency = 0
						end
					end)

					text1Button.MouseButton1Click:Connect(function()
						if newMt.Confirm then
							newMt:Confirm(chosenColor, text1)
						end
					end)
					text1Button.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							text1Button.BackgroundTransparency = 0.4
						end
					end)
					text1Button.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							text1Button.BackgroundTransparency = 0
						end
					end)

					text2Button.MouseButton1Click:Connect(function()
						if newMt.Confirm then
							newMt:Confirm(chosenColor, text2)
						end
					end)
					text2Button.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							text2Button.BackgroundTransparency = 0.4
						end
					end)
					text2Button.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							text2Button.BackgroundTransparency = 0
						end
					end)

					scrollButton.MouseButton1Click:Connect(function()
						if newMt.Confirm then
							newMt:Confirm(chosenColor, scroll)
						end
					end)
					scrollButton.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							scrollButton.BackgroundTransparency = 0.4
						end
					end)
					scrollButton.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							scrollButton.BackgroundTransparency = 0
						end
					end)

					cancelButton.MouseButton1Click:Connect(function()
						if newMt.Cancel then
							newMt:Cancel()
						end
					end)
					cancelButton.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							cancelButton.BackgroundTransparency = 0.4
						end
					end)
					cancelButton.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							cancelButton.BackgroundTransparency = 0
						end
					end)

					defaultButton.MouseButton1Click:Connect(function()
						if newMt.Default then
							newMt:Default()
						end
					end)
					defaultButton.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							defaultButton.BackgroundTransparency = 0.4
						end
					end)
					defaultButton.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							defaultButton.BackgroundTransparency = 0
						end
					end)

					pickerExit.MouseButton1Click:Connect(function()
						picker:TweenPosition(UDim2.new(0.5, -219, 0, -500), "InOut", "Quart", 0.5, true, nil)
					end)

					updateColor()

					newMt.SetColor = function(self, color)
						red, green, blue = color.r, color.g, color.b
						hue, sat, val = Color3.toHSV(color)
						updateColor()
					end

					return newMt
				end
			end

			picker:TweenPosition(UDim2.new(0.5, -219, 0, 100), "InOut", "Quart", 0.5, true, nil)

			local Npicker = ColorPicker.new()
			Npicker.Confirm = function(self, color, ctype)
				updateColors(color, ctype)
				wait()
				updatesaves()
			end
			Npicker.Cancel = function(self)
				updateColors(cache_currentShade1, shade1)
				updateColors(cache_currentShade2, shade2)
				updateColors(cache_currentShade3, shade3)
				updateColors(cache_currentText1, text1)
				updateColors(cache_currentText2, text2)
				updateColors(cache_currentScroll, scroll)
				wait()
				updatesaves()
			end
			Npicker.Default = function(self)
				updateColors(Color3.fromRGB(36, 36, 37), shade1)
				updateColors(Color3.fromRGB(46, 46, 47), shade2)
				updateColors(Color3.fromRGB(78, 78, 79), shade3)
				updateColors(Color3.new(1, 1, 1), text1)
				updateColors(Color3.new(0, 0, 0), text2)
				updateColors(Color3.fromRGB(78, 78, 79), scroll)
				wait()
				updatesaves()
			end
		else
			picker:TweenPosition(UDim2.new(0.5, -219, 0, 100), "InOut", "Quart", 0.5, true, nil)
		end
	end)

	SettingsButton.MouseButton1Click:Connect(function()
		if not SettingsOpen then
			SettingsOpen = true
			Settings:TweenPosition(UDim2.new(0, 0, 0, 45), "InOut", "Quart", 0.5, true, nil)
			CMDsF.Visible = false
		else
			SettingsOpen = false
			CMDsF.Visible = true
			Settings:TweenPosition(UDim2.new(0, 0, 0, 220), "InOut", "Quart", 0.5, true, nil)
		end
	end)

	On.MouseButton1Click:Connect(function()
		if not isHidden then
			if StayOpen == false then
				StayOpen = true
				On.BackgroundTransparency = 0
			else
				StayOpen = false
				On.BackgroundTransparency = 1
			end
			updatesaves()
		end
	end)

	Clear.MouseButton1Down:Connect(function()
		for _, child in pairs(scroll_2:GetChildren()) do
			child:Destroy()
		end
		scroll_2.CanvasSize = UDim2.new(0, 0, 0, 10)
	end)

	Clear_2.MouseButton1Down:Connect(function()
		for _, child in pairs(scroll_3:GetChildren()) do
			child:Destroy()
		end
		scroll_3.CanvasSize = UDim2.new(0, 0, 0, 10)
	end)

	Toggle.MouseButton1Down:Connect(function()
		if logsEnabled then
			logsEnabled = false
			Toggle.Text = "Disabled"
			updatesaves()
		else
			logsEnabled = true
			Toggle.Text = "Enabled"
			updatesaves()
		end
	end)

	Toggle_2.MouseButton1Down:Connect(function()
		if jLogsEnabled then
			jLogsEnabled = false
			Toggle_2.Text = "Disabled"
			updatesaves()
		else
			jLogsEnabled = true
			Toggle_2.Text = "Enabled"
			updatesaves()
		end
	end)

	selectChat.MouseButton1Down:Connect(function()
		join.Visible = false
		chat.Visible = true
		table.remove(shade3, table.find(shade3, selectChat))
		table.remove(shade2, table.find(shade2, selectJoin))
		table.insert(shade2, selectChat)
		table.insert(shade3, selectJoin)
		selectJoin.BackgroundColor3 = currentShade3
		selectChat.BackgroundColor3 = currentShade2
	end)

	selectJoin.MouseButton1Down:Connect(function()
		chat.Visible = false
		join.Visible = true
		table.remove(shade3, table.find(shade3, selectJoin))
		table.remove(shade2, table.find(shade2, selectChat))
		table.insert(shade2, selectJoin)
		table.insert(shade3, selectChat)
		selectChat.BackgroundColor3 = currentShade3
		selectJoin.BackgroundColor3 = currentShade2
	end)

	if not writefileExploit() then
		notify("Saves", "Your exploit does not support read/write file. Your settings will not save.")
	end

	return env
end
