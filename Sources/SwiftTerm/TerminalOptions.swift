//
//  TerminalOptions.swift
//  SwiftTerm
//
//  Created by Miguel de Icaza on 2/29/20.
//  Copyright © 2020 Miguel de Icaza. All rights reserved.
//

import Foundation

/// Configuration option for the desired cursor style, this style can also be overwritten by the application
/// inside the terminal, and the UI control can choose to honor this request.
public enum CursorStyle {
    case blinkBlock
    case steadyBlock
    case blinkUnderline
    case steadyUnderline
    case blinkBar
    case steadyBar
    
    public static func from (string: String) -> CursorStyle? {
        switch string {
        case "blinkBlock":
            return .blinkBlock
        case "steadyBlock":
            return .steadyBlock
        case "blinkUnderline":
            return .blinkUnderline
        case "steadyUnderline":
            return .steadyUnderline
        case "blinkBar":
            return .blinkBar
        case "steadyBar":
            return .steadyBar
        default:
            return nil
        }
    }
}

public enum CursorAnimationType: Codable, CaseIterable, CustomStringConvertible {
	case stretchAndMove //stretch and animate movements
	case move //only animate movements
	case none //no animations
	
	public var description: String {
		switch self {
		case .stretchAndMove:
			return "Stretch and Glide"
		case .move:
			return "Glide"
		case .none:
			return "None"
		}
	}
}

public struct CursorAnimations: Equatable, Codable {
	/// animation type
	public var type: CursorAnimationType
	
	/// stretch multiplier
	public var stretchMultiplier: CGFloat
	
	/// total animation length
	public var length: Double
	
	public static var `default`: CursorAnimations {
		CursorAnimations(type: .none, stretchMultiplier: 1, length: 0.2)
	}
	
	public init(
		type: CursorAnimationType = Self.default.type,
		stretchMultiplier: CGFloat = Self.default.stretchMultiplier,
		length: Double = Self.default.length
	) {
		self.type = type
		self.stretchMultiplier = stretchMultiplier
		self.length = length
	}
}

/// Configuration options for the terminal at startup, these values are only read at startup
public struct TerminalOptions {
    /// Desired number of columns at startup (default 80)
    public var cols: Int
    /// Desired number of rows at startup (default 25)
    public var rows: Int
    /// Controls whether a Line-Feed character will also behave like a carriage return (true) or not (false).  defaults to false)
    public var convertEol: Bool
    /// Desired value for the terminal name, defaults to xterm-color
    public var termName: String
    /// The desired startup cursor style, this merely sets an internal variable, it is the view job to render it
    public var cursorStyle: CursorStyle
	/// stores cursor animation preferences
	public var cursorAnimations: CursorAnimations
    /// Deprecated?   The new accessibility work will make this useless
    public var screenReaderMode: Bool
    /// Size of the scrollback buffer, defaults to 500 lines
    public var scrollback: Int
    /// Default size of the tabs, defaults to 8
    public var tabStopWidth: Int
    /// Whether to report that sixel support is present
    public var enableSixelReported:Bool
    
    /// Default options
    public static let `default` = TerminalOptions.init(cols: 80,
                                                       rows: 25,
                                                       convertEol: false,
                                                       termName: "xterm-256color",
                                                       cursorStyle: .blinkBlock,
													   cursorAnimations: CursorAnimations.default,
                                                       screenReaderMode: false,
                                                       scrollback: 500,
                                                       tabStopWidth: 8,
                                                       enableSixelReported: true)

  public init(cols: Int = Self.default.cols, rows: Int = Self.default.rows, convertEol: Bool = Self.default.convertEol, termName: String = Self.default.termName, cursorStyle: CursorStyle = Self.default.cursorStyle, cursorAnimations: CursorAnimations = Self.default.cursorAnimations, screenReaderMode: Bool = Self.default.screenReaderMode, scrollback: Int = Self.default.scrollback, tabStopWidth: Int = Self.default.tabStopWidth, enableSixelReported: Bool = Self.default.enableSixelReported) {
        self.cols = cols
        self.rows = rows
        self.convertEol = convertEol
        self.termName = termName
        self.cursorStyle = cursorStyle
        self.cursorAnimations = cursorAnimations
        self.screenReaderMode = screenReaderMode
        self.scrollback = scrollback
        self.tabStopWidth = tabStopWidth
        self.enableSixelReported = enableSixelReported
    }
}
