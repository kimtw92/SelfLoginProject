package ut.lib.util;

/**
 * @author Administrator
 *
 * To change the template for this generated type comment go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
import java.io.File;
import java.io.IOException;
import java.io.StringReader;
import java.net.URL;
import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import ut.lib.exception.BizException;
import ut.lib.log.Log;

public class XmlDomUtil
{

	private XmlDomUtil()
	{
	}


	public static Element loadXmlDocument(URL url) throws Exception
	{
		try
		{
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			InputSource xmlSrc = new InputSource(url.openStream());
			Document doc = builder.parse(xmlSrc);
			Element root = doc.getDocumentElement();
			root.normalize();
			return root;
		} catch(IOException ioexception) {
		    Log.error(XmlDomUtil.class, "[Exception in XmlDomUtil] " + url + " is not found");
		    throw new BizException("COMMON.MSG02");
		}
	}

	public static Element loadXmlDocument1(String xmlData) throws Exception
	{
		try
		{
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			InputSource xmlSrc = new InputSource(new StringReader(xmlData));
			Document doc = builder.parse(xmlSrc);
			Element root = doc.getDocumentElement();
			root.normalize();
			return root;
		} catch(IOException ioexception) {
		    Log.error(XmlDomUtil.class, "[Exception in XmlDomUtil] " + xmlData + " is not found");
		    throw new BizException("COMMON.MSG02");
		}
	}

	public static Element loadXmlDocument(String xmlFile_) throws Exception
	{
	    String xmlFile = xmlFile_;
		try
		{
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document doc = builder.parse(new File(xmlFile));
			Element root = doc.getDocumentElement();
			root.normalize();
			return root;
		} catch(IOException ioexception) {
		    Log.error(XmlDomUtil.class, "[Exception in XmlDomUtil] " + xmlFile + " is not found");
		    throw new BizException("COMMON.MSG02");

		}
	}

	public static String getTagValue(Element root, String tagName) throws Exception
	{
		NodeList nList = root.getElementsByTagName(tagName);
		String value = null;

		for(int i = 0; i < nList.getLength(); i++)
		{
			Node node = nList.item(i);
			if(node != null)
			{
				Node child = node.getFirstChild();
				if(child != null && child.getNodeValue() != null) {
					value = child.getNodeValue();
					break;
				}
			}
		}

		if (value == null) {
		    throw new BizException("COMMON.MSG03");
		}

		return value;
	}

	public static Element getTagElement(Element root, String tagName, String attributeName) throws Exception
	{
	    Element e = null;
		NodeList nList = root.getElementsByTagName(tagName);

		for(int i = 0; i < nList.getLength(); i++)
		{
			Node node = nList.item(i);

			if(node != null && node.hasAttributes())
			{
				String name = ((Element)node).getAttribute("name");
				if(name.equals(attributeName)) {
					e = (Element)node;
					break;
				}
			}
		}

		if (e == null) {
		    Log.error(XmlDomUtil.class, "[Exception in XmlDomUtil] [" + attributeName + "] element is not found");
		    throw new BizException("COMMON.MSG03");
		}

		return e;
	}

	public static String getTagValue(Element root, String tagName, String attributeName)
	{
		NodeList nList = root.getElementsByTagName(tagName);

		if (nList == null || nList.getLength()==0) {

		}

		String value = null;

		for(int i = 0; i < nList.getLength(); i++)
		{
			Node node = nList.item(i);

			if(node != null && node.hasAttributes())
			{
				String name = ((Element)node).getAttribute("name");

				if(name.equals(attributeName)) {
				    NodeList nList1 = node.getChildNodes();

				    if (nList1.getLength() == 1) {
				        value = node.getFirstChild().getNodeValue();
				    } else {
				        for (int j = 0; j < nList1.getLength(); j++) {
				            Node node1 = nList1.item(j);

				            if (node1.getNodeType() == 4) {
				                value = node1.getNodeValue();
				            }
				        }
				    }

					return value;
				}
			}
		}

		return null;
	}

	public static String getSubTagValue(Node node, String subTagName)
	{
		NodeList nList = node.getChildNodes();
		for(int i = 0; i < nList.getLength(); i++)
		{
			Node child = nList.item(i);
			if(child != null && child.getNodeName() != null && child.getNodeName().equals(subTagName))
			{
				Node grandChild = child.getFirstChild();
				if(grandChild.getNodeValue() != null)
					return grandChild.getNodeValue();
			}
		}

		return "";
	}

	public static String getSubTagValue(Element root, String tagName, String subTagName)
	{
		String returnString = "";
		NodeList list = root.getElementsByTagName(tagName);
		for(int loop = 0; loop < list.getLength(); loop++)
		{
			Node node = list.item(loop);
			if(node != null)
			{
				NodeList children = node.getChildNodes();
				for(int innerLoop = 0; innerLoop < children.getLength(); innerLoop++)
				{
					Node child = children.item(innerLoop);
					if(child != null && child.getNodeName() != null && child.getNodeName().equals(subTagName))
					{
						Node grandChild = child.getFirstChild();
						if(grandChild != null && grandChild.getNodeValue() != null)
							return grandChild.getNodeValue();
					}
				}

			}
		}

		return returnString;
	}

	public static ArrayList getSubTagValues(Element root, String tagName, String subTagName)
	{
		ArrayList results = new ArrayList();
		NodeList list = root.getElementsByTagName(tagName);
		for(int loop = 0; loop < list.getLength(); loop++)
		{
			Node node = list.item(loop);
			if(node != null)
			{
				NodeList children = node.getChildNodes();
				for(int innerLoop = 0; innerLoop < children.getLength(); innerLoop++)
				{
					Node child = children.item(innerLoop);
					if(child != null && child.getNodeName() != null && child.getNodeName().equals(subTagName))
					{
						Node grandChild = child.getFirstChild();
						if(grandChild != null && grandChild.getNodeValue() != null)
							results.add(grandChild.getNodeValue());
					}
				}

			}
		}

		return results;
	}

	public static String getSubTagAttribute(Element root, String tagName, String subTagName, String attribute)
	{
		String returnString = "";
		NodeList list = root.getElementsByTagName(tagName);
		for(int loop = 0; loop < list.getLength(); loop++)
		{
			Node node = list.item(loop);
			if(node != null)
			{
				NodeList children = node.getChildNodes();
				for(int innerLoop = 0; innerLoop < children.getLength(); innerLoop++)
				{
					Node child = children.item(innerLoop);
					if(child != null && child.getNodeName() != null && child.getNodeName().equals(subTagName) && (child instanceof Element))
						return ((Element)child).getAttribute(attribute);
				}

			}
		}

		return returnString;
	}

	public static String getAttribute(Node node, String attrName)
	{
		if(node != null && (node instanceof Element))
			return ((Element)node).getAttribute(attrName);
		else
			return "";
	}

	public static int updateSubTagValue(Element root, String tagName, String subTagName, String value)
	{
		NodeList list = root.getElementsByTagName(tagName);
		for(int loop = 0; loop < list.getLength(); loop++)
		{
			Node node = list.item(loop);
			if(node != null)
			{
				NodeList children = node.getChildNodes();
				for(int innerLoop = 0; innerLoop < children.getLength(); innerLoop++)
				{
					Node child = children.item(innerLoop);
					if(child != null && child.getNodeName() != null && child.getNodeName().equals(subTagName))
					{
						Node grandChild = child.getFirstChild();
						if(grandChild.getNodeValue() != null)
						{
							grandChild.setNodeValue(value);
							return 1;
						}
					}
				}

			}
		}

		return -1;
	}

	public static int removeSubTag(Element root, String tagName, String subTagName)
	{
		NodeList list = root.getElementsByTagName(tagName);
		for(int loop = 0; loop < list.getLength(); loop++)
		{
			Node node = list.item(loop);
			if(node != null)
			{
				NodeList children = node.getChildNodes();
				for(int innerLoop = 0; innerLoop < children.getLength(); innerLoop++)
				{
					Node child = children.item(innerLoop);
					if(child != null && child.getNodeName() != null && child.getNodeName().equals(subTagName))
					{
						node.removeChild(child);
						return 1;
					}
				}

			}
		}

		return -1;
	}

	public static int removeTag(Element root, String tagName)
	{
		NodeList list = root.getElementsByTagName(tagName);
		for(int loop = 0; loop < list.getLength(); loop++)
		{
			Node node = list.item(loop);
			if(node != null && node.getNodeName() != null && node.getNodeName().equals(tagName))
			{
				root.removeChild(node);
				return 1;
			}
		}

		return -1;
	}

	public static void appendTag(Element root, String tagName)
	{
		Document doc = root.getOwnerDocument();
		Element tmp = doc.createElement(tagName);
		root.appendChild(tmp);
	}

	public static void appendSubTag(Element root, String tagName, String subTagName)
	{
		Document doc = root.getOwnerDocument();
		NodeList list = root.getElementsByTagName(tagName);
		for(int loop = 0; loop < list.getLength(); loop++)
		{
			Node node = list.item(loop);
			if(node != null && node.getNodeName() != null && node.getNodeName().equals(tagName))
			{
				Element tmp = doc.createElement(subTagName);
				node.appendChild(tmp);
			}
		}

	}

	public static String getNodeTypeStr(short nodeType)
	{
		switch(nodeType)
		{
		case 2: // '\002'
			return "ATTRIBUTE_NODE";

		case 4: // '\004'
			return "CDATA_SECTION_NODE";

		case 8: // '\b'
			return "COMMENT_NODE";

		case 11: // '\013'
			return "DOCUMENT_FRAGMENT_NODE";

		case 9: // '\t'
			return "DOCUMENT_NODE";

		case 10: // '\n'
			return "DOCUMENT_TYPE_NODE";

		case 1: // '\001'
			return "ELEMENT_NODE";

		case 6: // '\006'
			return "ENTITY_NODE";

		case 5: // '\005'
			return "ENTITY_REFERENCE_NODE";

		case 12: // '\f'
			return "NOTATION_NODE";

		case 7: // '\007'
			return "PROCESSING_INSTRUCTION_NODE";

		case 3: // '\003'
			return "TEXT_NODE";
		}
		return "Unknown";
	}

	public static final int NOT_FOUND = -1;
	public static final int COMPLETE = 1;
}
